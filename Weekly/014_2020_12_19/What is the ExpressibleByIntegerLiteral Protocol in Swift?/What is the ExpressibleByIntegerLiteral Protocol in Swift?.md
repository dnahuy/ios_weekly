[Original Link](https://medium.com/cleansoftware/what-is-the-expressiblebyintegerliteral-protocol-in-swift-e71ad4a37a96)

# What is the ExpressibleByIntegerLiteral Protocol in Swift?
## Introduction
Bài viết giới thiệu về __ExpressibleByIntegerLiteral__ protocol

## Ví dụ
```swift
struct CustomNumber {
    let value: Int?
    let isEven: Bool?
}
```
Giả sử ta cần tạo ra 1 array của CustomNumber, ta sẽ phải viết như sau:
```swift
let customNumbers: [CustomNumber] =
    [
        .init(value: 4),
        .init(value: 24),
        .init(value: 65),
        .init(value: 44)
    ]
```
Nếu sử dụng ExpressibleByIntegerLiteral  protocol, ta có thể viết lại gọn hơn rất nhiều
```swift
extension CustomNumber: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.value = value
        self.isEven = self.value?.isMultiple(of: 2)
    }
}

let customNumbers: [CustomNumber] = [1, 13, 22, 56, 28]
```