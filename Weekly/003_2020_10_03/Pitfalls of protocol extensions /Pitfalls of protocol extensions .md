[Original Link](https://dmtopolog.com/pitfalls-of-protocol-extensions/)

# Pitfalls of protocol extensions
## Introduction
Trong 1 bài blog trước đó tác giả đã giới thiệu sức mạng của protocol extension, bài này chủ yếu tác giả viết về các negatives của nó.

## Tăng độ phức tạp
```swift
struct MyCollection { ... }

extension MyCollection: Filtrable {}

protocol Filtrable { ... }

extension Filtrable {
  func filter() {
    // functionality
  }
}
```
Khi chúng ta sử dụng protocol thì rõ ràng chúng ta đã làm tăng tính abstract của code lên -> sử dụng extension của protocol lại càng làm tăng nó lên.
 Khi debug hoặc decode thường phải nhớ protocol và type đang conform nó

## Static nature của additonal functionality
```swift
// we have a var of a type `NewsProvider`
var newsProvider: NewsProvider

// at some point we assign it an instance of a specific type
newsProvider = RussiaTodayNewsProvider()

// at some point we do the filtering
let filteredNews = newsProvider.applyFilter(filter: filter)

// NewsProvider.applyFilter() implementation is used
```

Trong trường hợp này thì method được gọi sẽ là method default của protocol chứ ko phải method của class đang hiện thực protocol đó.

## Thay đổi funciton signature
```swift
extension NewsProvider {    
    func applyFilter(filter: Filter) {
        // default implementation
    }
}

struct RussiaTodayNewsProvider: NewsProvider {
    func applyFilter(filter: Filter) {
        // specific implementation... cause you know...
        // these official Russian news agencies require some extra filtering
    }
}

extension NewsProvider {    
    func applyFilter(filter: Filter, removeFakeNews: Bool = false) {
        // default implementation
    }
}

var newsProvider: NewsProvider
newsProvider.applyFilter(filter: Filter, removeFakeNews: true)

function applyFilter của RussiaTodayNewsProvider có thể bị miss
```

## Testability 
```swift
extension NewsProvider {
    func applyFilter(filter: Filter) {
        // implementation
    }
}

class NewsFeedViewModel {
    var newsProvider: NewsProvider

    // ...

    func filterNews() {
        newsProvider.applyFilter(filter: filter)
        //...
    }
}
```

Ta có thể mocking NewsProvider nhưng không có cách nào override được hàm default applyFiter của nó.