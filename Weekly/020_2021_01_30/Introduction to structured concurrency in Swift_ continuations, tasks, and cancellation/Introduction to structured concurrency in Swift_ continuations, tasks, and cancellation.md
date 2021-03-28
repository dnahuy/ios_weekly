[Original Link](https://desiatov.com/swift-structured-concurrency-introduction/)

# Introduction to structured concurrency in Swift: continuations, tasks, and cancellation
## Introduction
Bài viết giới thiệu về ___Structured Concurrency___ trong Swift, bao gồm: ___continuation, task__ và ___cancellation___. Tính năng này trong Swift thực ra vẫn đang experimental chứ chưa được implement chính thức.
Trong bài viết, tác giả có code 1 CLI SwiftPM project để làm ví dụ minh hoạ cho việc sử dụng Structured Concurrency.

## Continuation
Giúp return về 1 async để ta có thể gọi asyncronously.

```swift
struct UnsafeContinuation<T> {
  func resume(returning: T)
}

func withUnsafeContinuation<T>(
    operation: (UnsafeContinuation<T>) -> ()
) async -> T
```

Ngoài ra còn có continuation có thể throwing

```swift
struct UnsafeThrowingContinuation<T, E: Error> {
  func resume(returning: T)
  func resume(throwing: E)
}

func withUnsafeThrowingContinuation<T>(
    operation: (UnsafeThrowingContinuation<T, Error>) -> ()
) async throws -> 
```
Do return là 1 async nên ta có thể sử dụng với await như sau:

```swift
await withUnsafeContinuation { c in
    DispatchQueue.global()
        .asyncAfter(deadline: .now() + .seconds(seconds)) {
            c.resume(returning: ())
        }
}
```

Dựa trên hàm này, chúng ta có thể convert 1 hàm gọi theo kiểu callback completion thông thường thành dạng async/await. Ví dụ như URLSession.shared.dataTask

```swift
try await withUnsafeThrowingContinuation { c in
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            switch (data, error) {
            case let (_, error?):
                return c.resume(throwing: error)
            case let (data?, _):
                return c.resume(returning: data)
            case (nil, nil):
                c.resume(throwing: UnknownError())
            }
        }
        task.resume()
    }
```

## Entry Point
Từ non-async code, ta có thể gọi các hàm async bằng runAsyncAndBlock

```swift
runAsyncAndBlock {
    print("task started")
    let data = try! await download("https://httpbin.org/uuid")
    print(String(data: data, encoding: .utf8)!)
}
```

Lưu ý, không gọi hàm này ở trên UI thread vì nó sẽ gây block UI.

## async let
Tương tự như __DispatchGroup__, ta có thể chạy nhiều async đồng thời và await tất cả các async đó. Các async này sẻ giống như các child taks

```swift
func childTasks() async throws -> String {
    print("\(#function) started")

    async let uuid1 = download("https://httpbin.org/uuid")
    async let uuid2 = download("https://httpbin.org/uuid")

    return try await """
    ids fetched concurrently:
    uuid1: \(String(data: uuid1, encoding: .utf8)!)
    uuid2: \(String(data: uuid2, encoding: .utf8)!)
    """
}
```

Hàm childTasks là 1 hàm async trong đó có 2 async con là uuid1 và uuid2 

## Cancellation
async let ở trên tạo thành task hierachy với parent và childs, khi parent task bị cancelled thì child tasks cũng sẽ bị cancelled. Cancellation trong Structured Concurrency có tính phối hợp (cooperative). Tức là các tasks cần phối hợp với nhau theo 1 cách rõ ràng để có thể cancel ngay khi có thể. Ta có 2 hàm static là isCancelled và checkCancellation để kiểm tra xem task đã bị cancel hay chưa.
```swift
try await Task.checkCancellation() 
```
được excute trong 1 task sẽ throw Task.CancellationError nếu task đã được cancel trước đó.

## Task handlers
Để có thể cancel, ta phải get handle của Task, ta có thể làm bằng cách gọi hàm runDetached
```swift
let handle = Task.runDetached {
    await sleep(seconds: 1)
    try await print(childTasks())
}
```

Ở đoạn code trên, childTasks() là 1 task con của parent task gồm có sleep và childTasks. 

```swift
handle.cancel()
Parent task bị cancel nên childTasks cũng sẽ bị cancel

do {
    try await handle.get()
} catch {
    if error is Task.CancellationError {
        print("task cancelled")
    } else {
        print(error)
    }
}
```