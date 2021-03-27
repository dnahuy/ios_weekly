[Original Link](https://medium.com/geekculture/why-swift-reference-types-are-bad-for-app-startup-time-90fbb25237fc)

# Why Swift Reference Types Are Bad for App Startup Time

## Introduction
This blog explain how reference types make app startup time longer and what can be done to improve.

## dlyd
App starts when __Mach-O executable__ is loaded by __dlyd__. Dyld loads all dependent framework, including any system frameworks. __Binary metadata__ describes types in your source code. This metadata allows for __dynamic runtime__ features but also make binary size large.
```swift
struct ObjcClass {
  let isa: UInt64
  let superclass: UInt64
  let cache: UInt64
  let mask: UInt32
  let occupied: UInt32
  let taggedData: UInt64
}
```
Each UInt64 is the address of another piece of metadata. However, each time app is launched, it’s placed in in a different location of memory because of __address space layout randomization (ASLR).__
So the address hardcoded into app binary is now wrong. __dlyd__ is responsible for correcting this by __rebasing all pointers__ to take into account the unique start location.
This process is done for every pointer in your executable and all depedent frameworks. So reducing it results in a smaller app binary and a faster start time.

## Composition and Inheritance 
Inheritance will generate a lot of metadata, but we maybe represent the same idea with value types. Replace object inheritance with value composition, such as enums with associated values or generic types.
```swift
struct Section<SectionType: Decodable>: Decodable {
  let name: String
  let id: Int
  let type: SectionType
}

struct TextRow: Decodable {
  let title: String
  let subtitle: String
}

struct ImageRow: Decodable {
  let imageURL: URL
  let accessibilityLabel: String
}
```

## Categories in Swift
Using extension in Swift, we can still generate category binary metadata if we declare an extension that uses an Objective C function.

```swift
extension TestClass {
  @objc
  func foo() { }
 
  override func bar() { }
}
```

Both functions are included in binary metadata, but since they are declared in an extension, they are referred by a synthesized category on TestClass.
Move these functions into the original class declaration to avoid the extra overhead of category metadata being included in binary.

## Many properties
Properties in a Swift class each add 3 to 6 rebasing fixups, depending on if the class is final.

```swift
final class TestClass {
  var property1: Int = 0
  var property2: Int = 0
  ...
  var property20: Int = 0
}
```

Converting it to be backed by a struct reduces the number of rebase fixups by 60%
```swift
final class TestClass {
  struct Content {
    var property1: Int = 0
    var property2: Int = 0
    ...
    var property20: Int = 0
  }
 
  var content: Content = .init()
}
```