[Original Link](https://fivestars.blog/swift/disfavoredOverload.html)

# Swift overloading and @_disfavoredOverload
## Introduction
Bài viết giới thiệu về overloading trong Swift và vài tình huống nhập nhằng mà ta có thể gặp phải. Ngoài ra còn giới thiệu về @_disfavoredOverload

## Hidden principle
Jordan Rose: [“The general principle is that the most specific overload should win”.](https://forums.swift.org/t/compiler-choosing-between-functions-with-no-parameters-vs-functions-with-default-parameters/23501/2)

#### Void vs default value
```swift
func sameName() {
  ...
}

func sameName(value: Int = 5) {
  ...
}
```
_sameName()_ specific hơn _sameName(value:)_. Do đó, sameName() được gọi

#### Protocol và conforming type của protocol
```swift
func sameName(_ number: Int) {
  ...
}

func sameName<N: Numeric>(_ number: N) {
  ...
}
```
sameName(_ Int) specific hơn sameName<N: Numeric>(_ N). Do đó, sameName(_ Int)  được gọi.

#### Variadic vs non
```swift
func sameName(_ number: Int) {
  ...
}

func sameName(_ numbers: Int...) {
  ...
}
```
sameName(_ Int) specific hơn sameName(_ Int….). Do đó, sameName(_ Int)  được gọi.

## @_disfavoredOverload
The underscore in front of the attribute means that this Swift feature hasn’t gone through Swift Evolution just yet, proceed at your own discretion.

Dùng @_disfavoredOverload sẽ __hạ rank__ của func đi kèm. 
Ví dụ

```swift
@_disfavoredOverload 
func sameName() {
  ...
}

func sameName(value: Int = 5) {
  ...
}
```

Hàm sameName() lúc này lại được xem là ít specific hơn sameName(value: Int). Do đó, sameName(value: Int) sẽ được gọi. 

## SwiftUI
SwiftUI dựa rất nhiều vào @_disfavoredOverload trong các declaration.
Ví dụ: Text trong SwiftUI
```swift
public init<S: StringProtocol>(_ content: S)
public init(_ key: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil)
```
Hàm init đầu tiên specific hơn hàm thứ 2 nhưng hàm đầu tiên init<S: StringProtocol> đã được gán @_disfavoredOverload.
