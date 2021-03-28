[Original Link](https://medium.com/swift-gurus/hidden-gems-of-swift-result-understanding-through-implementation-4fbf177e5fcd)

# “Hidden” Gems of Swift Result. Understanding through implementation.
## Introduction
Bài viết giới thiệu 1 trường hợp dùng Swift Result trong thực tế giúp làm cho code nhìn clean hơn.

## Ban đầu
```swift
class UserItemsViewController {
   // prepare view code
  var service: UserDataBaseService!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadItems()
  }
   
  private func loadItems() {
    // 1
    guard let userID = service.currentUser?.id else {
      // possibly show pop up that a user is not logged in
      return
    }
     
    // 2
    guard let category = service.category(for userID: String) else {
      // possibly show pop ups for data base errors
      return
    }
    
    // 3
    guard let items = service.items(for: category.id) else {
      // possibly show pop ups for data base errors
      return
    }
    self.dataSource = items
    self.tableView.reloadData()
    
  }
}
```
Chúng ta sử dụng guard let quá nhiều rồi mới có thể reload TableView

## Viết lại bằng Result
```swift
class UserItemsViewController {
   // prepare view code
  var service: UserDataBaseService!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadItems()
  }
   
  private func loadItems() {
    service.currentUser.flatMap(service.getCategory)
                       .flatMap(service.service.items)
                       .do{ sourceItems = $0 }
                       .do{ tableView.reloadData() }
                       .onError{ debugPring($0) }
  }
}
```
Ý tưởng chủ yếu ở đây là có thể sử dụng Swift Result với flatMap —> giúp lan truyền Result.
* __Result.map:__ trả về value của Result
* __Result.flatMap:__ trả về 1 Result mới
