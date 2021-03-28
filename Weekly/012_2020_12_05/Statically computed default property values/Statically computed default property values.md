[Original Link](https://www.swiftbysundell.com/tips/statically-computed-default-property-values/)

# Statically computed default property values
## Introduction
Bài viết trình bày về 1 vài case có thể gặp khi make default cho property.

## Thông thường
```swift
class DateView: UIView {
    var date = Date()
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    ...
}
```
Tuy nhiên sẽ làm cho code khó đọc, ta muốn tách rời phần declare với body của computed.

## Sử dụng lazy
```swift
class DateView: UIView {
    var date = Date()
    lazy var formatter = makeFormatter()
    
    ...
}

private extension DateView {
    func makeFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}
```
Tuy nhiên, cách này chỉ work cho trường hợp class, nếu dùng cho  struct sẽ bị compile error.

## Cách giải quyết: Sử dụng static
```swift
struct DateView: View {
    var date = Date()
    var formatter = makeFormatter()

    var body: some View {
        ...
    }
}

private extension DateView {
    static func makeFormatter() -> DateFormatter {
        ...
    }
}
```
Thực ra, ta có thể sử dụng bất kỳ static api nào để compute default valute cho property, cho phép chúng ta chỉ cần sử dụng 1 single shared statically cho tất cả các instances. 
Việc này có thể giúp improve performance vì chúng ta không cần phải tạo lại new instance.
```swift
struct DateView: View {
    var date = Date()
    var formatter = defaultFormatter

    var body: some View {
        ...
    }
}

private extension DateView {
    static let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
```
## Khác biệt quan trọng giữa lazy và non-lazy property
Khi compute 1 lazy property’s default value, chúng ta ở trong __context của instance__. Nếu compute default value cho non-lazy property, chúng ta ở trong __static context__.