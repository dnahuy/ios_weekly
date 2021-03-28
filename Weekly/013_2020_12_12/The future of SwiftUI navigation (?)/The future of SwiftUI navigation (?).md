[Original Link](https://fivestars.blog/swiftui/programmatic-navigation.html)

# The future of SwiftUI navigation (?)
## Introduction
Bài viết giới thiệu về 1 cách sử dụng NavigationLink trong SwiftUI ngắn gọn hơn.
```swift
struct ContentView: View {
  @State var showingNavigation: Bool = false

  var body: some View {
    NavigationView {
      NavigationLink(
        "Push view",
        destination: Button("Pop back", action: { showingNavigation = false }),
        isActive: $showingNavigation
      )
    }
  }
}
```
NavigationLink bình thường dùng sẽ có Label (là 1 view), destination (là view sẽ navigate đến), và 1 state (isActive)

## EmptyView
Do Label là 1 View nên ta có thể dùng __EmptyView__ để “ẩn” đi NavigationLink trên UI.
```swift
NavigationLink(
  destination: ...,
  isActive: ...,
  label: { EmptyView() }
)

struct ContentView: View {
  @State var showingNavigation: Bool = false

  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(
          destination: Button("Pop back", action: { showingNavigation = false }),
          isActive: $showingNavigation,
          label: { EmptyView() }
        )

        Button("Push view", action: { showingNavigation = true })
      }
    }
  }
}
```
Như trong body của ContentView ta có thể thấy, hiện giờ chỉ show lên Button để control việc navigate sang View tiếp theo.

## Identifiable và NavigationLink
Chúng ta có thể tạo ra 1 enum thoả Identifiable protocol để quy định View nào sẽ được destinate đến.
```swift
struct ContentView: View {
  @State private var showingNavigation: ContentViewNavigation?

  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(item: $showingNavigation, destination: presentNavigation)

        Button("Go to navigation one") {
          showingNavigation = .one
        }
        Button("Go to navigation two") {
          showingNavigation = .two(number: Int.random(in: 1...5))
        }
        Button("Go to navigation three") {
          showingNavigation = .three(text: ["five", "stars"].randomElement()!)
        }
      }
    }
  }

  @ViewBuilder
  func presentNavigation(_ navigation: ContentViewNavigation) -> some View {
    switch navigation {
    case .one:
      Text(verbatim: "one")
    case .two(let number):
      Text("two \(number)")
    case .three(let text):
      Text("three \(text)")
    }
  }
}
```
## NavigationLink
Trong đoạn code ở trên, NavigationLink được đặt trong VStack nhưng thật ra nó có thể đặt ở bất cứ đâu (vì thực sự nó còn không cần phải show lên UI nếu ta set Label là 1 EmptyView).
Do đó, ta có thể đặt nó trong background , ngoài ra ta có thể tạo ra 1 extension cho View để đoạn code sẽ trông gọn gàng và dễ hiểu hơn rất nhiều
```swift
extension View {
  func navigation<V: Identifiable, Destination: View>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination
  ) -> some View {
    background(NavigationLink(item: item, destination: destination))
  }
}

struct ContentView: View {
  ...

  var body: some View {
    NavigationView {
      VStack {
        Button(...) { ... }
        Button(...) { ... }
        Button(...) { ... }
      }
      .navigation(item: $showingNavigation, destination: presentNavigation)
    }
  }

  ...
}
```