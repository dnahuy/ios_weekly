[Original Link](https://fivestars.blog/swiftui/adaptive-swiftui-views.html)

# Adaptive SwiftUI views
## Introduction
Bài viết mô tả cách thực hiện Adaptive cho SwiftUI views

## Size Classes
Dựa vào sự thay đổi của Environment Size Classes để dựng layout tương ứng.
```swift
public enum UserInterfaceSizeClass {
  case compact
  case regular
}

struct AdaptiveView<Content: View>: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  var content: Content

  init(...) { ... }

  var body: some View {
    if horizontalSizeClass == .regular {
      // We have a "regular" horizontal screen estate: 
      // we lay the content horizontally.
      HStack {
        content
      }
    } else {
      VStack {
        content
      }
    }
  }
}
```

## Dynamic Type
Cũng tương tự như size class, cách này sẽ dựa vào Dynamic Type
```swift
public enum ContentSizeCategory: Hashable, CaseIterable {
  case extraSmall
  case small
  case medium
  case large
  case extraLarge
  case extraExtraLarge
  case extraExtraExtraLarge
  case accessibilityMedium
  case accessibilityLarge
  case accessibilityExtraLarge
  case accessibilityExtraExtraLarge
  case accessibilityExtraExtraExtraLarge
}


struct AdaptiveView<Content: View>: View {
  @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
  var content: Content

  ….
}
```

## Custom threshold
Cách tiếp cận này sẽ không dựa vào các biến global như Size Class hay Dynamic Type mà sẽ custom tuỳ theo từng View và content của nó.
```swift
struct AdaptiveView<Content: View>: View {
  @State private var availableWidth: CGFloat = 0
  var threshold: CGFloat
  var content: Content

  public init(
    threshold: CGFloat, 
    @ViewBuilder content: () -> Content
  ) {
    self.threshold = threshold
    self.content = content()
  }

  var body: some View {
    ZStack {
      Color.clear
        .frame(height: 1)
        .readSize { size in
          availableWidth = size.width
        }

      if availableWidth > threshold {
        HStack {
          content
        }
      } else {
        VStack {
          content
        }
      }
    }
  }
}
```

Ví dụ trên sẽ dựa vào available width so với 1 threshold nào đó để quyết định xem nên render content theo HStack hay VStack.
