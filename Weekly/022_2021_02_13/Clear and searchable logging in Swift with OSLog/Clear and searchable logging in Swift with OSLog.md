[Original Link](https://www.lordcodes.com/articles/clear-and-searchable-logging-in-swift-with-oslog)

# Clear and searchable logging in Swift with OSLog
## Introduction
Bài viết giới thiệu về unified logging, là 1 logging system được Apple recommend thay cho các kiểu logging cũ. Unified Logging có từ iOS 10.0 Ưu điểm của Log System mới là nó low performance.

## os_log / Logger
```swift
let errorMessage: StaticString = "404 - NOT FOUND"
os_log(errorMessage)
```
iOS 14.0 giới thiệu Logger và không còn force phải sử dụng StaticString như os_log
```swift
let count = 0
let logger = Logger.init(subsystem: “com.mandy.loggingdemo”, category: “main”)
logger.debug(“Start \(count) network call”)
```

## organised
Lúc tạo Logger hoặc os_log, ta có thể set subsytem và category để tiện cho việc filter và search log. Thường subsystem sẽ là 1 app cụ thể hoặc là 1 module nào đó, chẳng hạn như nó có thể là Bundle Identifier của app hoặc framework. Category thường sẽ liên quan đến 1 area nào đó, ví dụ: UI, User, Contact, v.v…

## Logging level
* ___Default:___ Log System sẽ lưu những log này xuống memory và move qua disk khi memory đạt limit
* ___Error:___ thường dùng khi có lỗi xảy ra trong App. Error sẽ luôn được lưu xuống disk.
* ___Fault:___ thường dùng khi có lỗi xảy ra trong system, chẳng hạn như device hết dung lượng. Fault cũng sẽ luôn * được lưu xuống disk.
* ___Info:___ Dùng để capture mọi thông tin mà ta cho là hữu ích. Info sẽ không được lưu xuống disk và sẽ bị clear khỏi memory khi limit.
* ___Debug:___ Dùng để capture các thông tin trong quá trình dev, và thường sẽ không dùng cho production code. Debug Level cần phải được enabled bằng configuration change nếu không sẽ không có gì output ra.

## User privacy
```swift
os_log("Contact %ld selected", 2)
os_log("Contact %{private}ld selected", 2)

os_log("HTTP response: %@", responseCode)
os_log("HTTP response: %{public}@", responseCode)
```
Nếu simulator hoặc device không được attached với Debugger thì những data nào thuộc loại private sẽ bị hidden đi trong log (sẽ show ra chữ <private> thay vì show nội dung).
Mặc định các kiểu scalar sẽ là public còn các kiểu còn lại (string, object, v.v…) sẽ là private. Ngoài ra, ta có thể set public hoặc private bằng cách dùng ___%{private}___ hoặc ___%{public}___

Hoặc nếu ta dùng Logger
```swift
logger.log("Bank account number \(XXXXXXXX, privacy: .private)")
```

## Reading logs
Nếu debugger đã được attached, logs sẽ được hiện lên trong XCode Console. Tuy nhiên, cách tốt nhất để đọc logs là dùng Console.app của Mac.
Ta có thể sort, search và filter. Ngoài ra, ta có thể đọc file log đã được archived từ device. Team QC có thể đưa test device cho Dev để export file log ra và dùng Console.app để đọc và investigate issues.