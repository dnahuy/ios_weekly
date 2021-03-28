[Original Link](https://useyourloaf.com/blog/adding-views-and-modifiers-to-the-xcode-library)

# Adding Views and Modifiers to the Xcode Library
## Introduction
XCode 12 cho phép chúng ta add các custom SwiftUI views và modifiers vào XCode Library.

## Adding Custom View
Để Custom View được hiện trong XCode Library, chúng ta cần tạo ra 1 Library Content Provider
```swift
struct AdaptiveStackLibrary: LibraryContentProvider {
  var views: [LibraryItem] {
    LibraryItem(AdaptiveStack {
      Text("Hello")
    }, category: .layout, matchingSignature: "asv")
}
```

## View Modifiers
Ta cũng sẽ làm gần tương tự cho trường hợp Custom View
```swift
struct ModifierLibrary: LibraryContentProvider {
  @LibraryContentBuilder
  func modifiers(base: Text) -> [LibraryItem] {
    LibraryItem(base.outerBorder(padding: 20.0, 
      color: .black, width: 5.0), category: .effect)
  }
}
```