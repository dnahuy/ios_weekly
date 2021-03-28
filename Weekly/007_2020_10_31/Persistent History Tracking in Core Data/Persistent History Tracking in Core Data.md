[Original Link](https://medium.com/better-programming/persistent-history-tracking-in-core-data-f44ab39691ed)

# Persistent History Tracking in Core Data
## Introduction
Chúng ta đã biết App và Extension có thể share chung Data (bằng Core Data). 
Bài viết giới thiệu về history tracking và cách share history giữa các app target (thường là App và các Extensions).
Mục đích là để nếu có 1 change data xảy ra ở Extension chẳng hạn thì App có thể được notify và update change trong App.

## Persistent History Tracking
Khi bật Persistent History Tracking, app sẽ ghi lại transaction cho bất cứ thay đổi data nào trong Core Data store.
Dù cho thay đổi này đến từ Extension, Background Context hay từ Main App, tất cả đều được ghi vào history.
Mỗi app target có thể fetch các history từ này từ 1 ngày cho trước và merge các thay đổi này vào local store của chúng. 
Sau khi merge ta có thể update lại merged date để lần sau chỉ cần fetch từ ngày đó trở đi.

## Bật Persistent History Tracking
Chúng ta sẽ bật __HistoryTrackingKey__ và __StoreRemoteChangeNotificationPostOptionKey__
```swift
let storeDescription = NSPersistentStoreDescription()
storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
```
## Lắng nghe 
```swift
public func startObserving() {
    NotificationCenter.default.addObserver(
       self, 
       selector: #selector(processStoreRemoteChanges), 
       name: .NSPersistentStoreRemoteChange, 
       object: persistentContainer.persistentStoreCoordinator)
}

/// Process persistent history to merge changes from other coordinators.
@objc private func processStoreRemoteChanges(_ notification: Notification) {
    historyQueue.addOperation { [weak self] in
        self?.processPersistentHistory()
    }
}

@objc private func processPersistentHistory() {
    let context = persistentContainer.newBackgroundContext()
    context.performAndWait {
        do {
            /// .. Perform merge
            /// .. Perform clean up
        } catch {
            print("Persistent History Tracking failed with error \(error)")
        }
    }
}
```
## Merge Transactions vào App Target
```swift
func merge() throws {
    let fromDate = userDefaults.lastHistoryTransactionTimestamp(for: currentTarget) ?? .distantPast
    let fetcher = PersistentHistoryFetcher(context: backgroundContext, fromDate: fromDate)
    let history = try fetcher.fetch()

    guard !history.isEmpty else {
        print("No history transactions found to merge for target \(currentTarget)")
        return
    }

    print("Merging \(history.count) persistent history transactions for target \(currentTarget)")

    history.merge(into: backgroundContext)

    viewContext.perform {
        history.merge(into: self.viewContext)
    }

    guard let lastTimestamp = history.last?.timestamp else { return }
    userDefaults.updateLastHistoryTransactionTimestamp(for: currentTarget, to: lastTimestamp)
}
```

## Transactions Fetcher
```swift
func fetch() throws -> [NSPersistentHistoryTransaction] {
    let fetchRequest = createFetchRequest()

    guard let historyResult = try context.execute(fetchRequest) as? NSPersistentHistoryResult,
          let history = historyResult.result as? [NSPersistentHistoryTransaction]
    else {
        throw Error.historyTransactionConvertionFailed
    }

    return history
}

func createFetchRequest() -> NSPersistentHistoryChangeRequest {
    let historyFetchRequest = NSPersistentHistoryChangeRequest
        .fetchHistory(after: fromDate)

    if let fetchRequest = NSPersistentHistoryTransaction.fetchRequest {
        var predicates: [NSPredicate] = []

        if let transactionAuthor = context.transactionAuthor {
            /// Only look at transactions created by other targets.
            predicates.append(NSPredicate(format: "%K != %@", #keyPath(NSPersistentHistoryTransaction.author), transactionAuthor))
        }
        if let contextName = context.name {
            /// Only look at transactions not from our current context.
            predicates.append(NSPredicate(format: "%K != %@", #keyPath(NSPersistentHistoryTransaction.contextName), contextName))
        }

        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        historyFetchRequest.fetchRequest = fetchRequest
    }

    return historyFetchRequest
}
```

## Clean up History
```swift
/// Cleans up the persistent history by deleting the transactions that have been merged into each target.
func clean() throws {
    guard let timestamp = userDefaults.lastCommonTransactionTimestamp(in: targets) else {
        print("Cancelling deletions as there is no common transaction timestamp")
        return
    }

    let deleteHistoryRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: timestamp)
    print("Deleting persistent history using common timestamp \(timestamp)")
    try context.execute(deleteHistoryRequest)

    targets.forEach { target in
        /// Reset the dates as we would otherwise end up in an infinite loop.
        userDefaults.updateLastHistoryTransactionTimestamp(for: target, to: nil)
    }
}
```