[Original Link](https://fivestars.blog/swiftui/design-system-composing-views.html)

# Composing SwiftUI views
## Introduction
Bài viết mô tả về quá trình tác giả phát triển 1 SwiftUI TextView tăng trưởng dần dần.

## Ban đầu
```swift
struct FSTextField: View {
    ....
}
```

Dựa vào design ban đầu, tác giả define ra được 1 TextView thoả đúng với requirement của Designer.

## Các thay đổi
Theo thời gian dần dần design của TextView càng ngày càng thay đổi, tác giả trình bày các cách để “compose” design mới từ TextView ban đầu.
Ví dụ:
```swift
struct _FSTextField: View {
    ....
}
```

TextView ban đầu giờ trở thành Core Component

## Generic text fields: Composable Views
```swift
struct FSTextField<TopContent: View>: View {
  var topContent: TopContent

  init(
    placeholder: LocalizedStringKey = "",
    text: Binding<String>,
    appearance: Appearance = .default,
    @ViewBuilder topContent: () -> TopContent
  ) {
    self.topContent = topContent()
  }

  var body: some View {
    VStack {
      topContent
      _FSTextField(
        placeholder: placeholder,
        text: $text,
        borderColor: borderColor
      )
    }
  }
}
```

Tác giả trình bày 1 cách tạo 1 TextField mới bằng cách “bọc” cho __CoreComponent (_FSTextField)___ thêm 1 __TopContent (ViewBuilder)__.
Ngoài cách trên ta có thể có rất nhiều cách custom khác nhau đối CoreComponent.
1 ví dụ cho việc sử dụng FSTextField

```swift
FSTextField(
  placeholder: "Placeholder",
  text: $myText
) {
  EmptyView()
}
```