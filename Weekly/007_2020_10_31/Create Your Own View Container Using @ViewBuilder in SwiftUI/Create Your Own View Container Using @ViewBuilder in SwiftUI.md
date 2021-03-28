[Original Link](https://betterprogramming.pub/create-your-own-view-container-using-viewbuilder-in-swiftui-316a5aca5fd3)

# Create Your Own View Container Using @ViewBuilder in SwiftUI
## Introduction
Bài viết hướng dẫn cách sử dụng ViewBuilder trong SwiftUI
```swift
struct Container <Content : View> : View {
    var content : Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.green)
            .cornerRadius(20)
    }
}

struct ContentView: View {
    var body: some View {
        Container {
            Text("This is my")
            Text("Container's content")
        }
    }
}
```

Như ví dụ trên, Container là 1 ViewBuilder giúp add thêm padding và green background color cũng như set cornerRadius = 20 cho view được truyền vào.
Ở body của ContentView, view được truyền vào cho ViewBuilder là 1 view có chứa 2 Text.
