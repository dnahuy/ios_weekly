[Original Link](https://medium.com/swlh/thoughts-on-the-contemporary-ios-development-345bdd3373fe)

# (Thoughts on) the Contemporary iOS Development
## Introduction
Bài viết giới thiệu về những công nghệ mới trong iOS development 

## Swift Package Manager
Với SPM, việc modularization sẽ trở nên đơn giản hơn rất nhiều. Có thể trong tương lai SPM sẽ thay thế cho CocoaPods hoặc Carthage

## SF Symbol
1 tập hợp của rất nhiều icon có sẵn. SF symbols có thể được vẽ (bằng Color khác nhau), hỗ trợ localizations và có semantics tương tự như font glyphs, ví dụ ta có thể chọn size hoặc weight.

```swift
let symbol = UIImage(systemName: "staroflife")
```

## Combine
Giải pháp của Apple cho Reactive Programming, chạy nhanh hơn so với các third party như RxSwift.

## SwiftUI
Chắc chắn là chủ đề hot nhất hiện nay trong iOS programming, với những update gần đây (SwiftUI 2.0) gần như không còn phụ thuộc nữa vào UIKit. Đặc biệt là với __@main__, SwiftUI đã có 1 entry point mới thay vì phải dùng các application/scene delegate của UIKit. Dĩ nhiên là hiện tại ta vẫn chưa thể loại bỏ hoàn toàn UIKit.

#### Syntax
Syntax rất dễ viết nhưng có phần khó đọc và maintain.

#### Độc lập khỏi UIKit?
Như đã đề cập, hiện chúng ta vẫn chưa thể loại bỏ hoàn toàn UIKit.  Ví dụ, change navigation bar color sẽ vẫn cần dùng UIKit.

```swift
private func configureNavigationBar() {
  UINavigationBar.appearance().backgroundColor
    = UIColor(red: (172.0 / 255.0),
              green: (211.0 / 255.0),
              blue: (214.0 / 255.0),
              alpha: 1.0)
  UINavigationBar.appearance().titleTextAttributes
    = [.foregroundColor : UIColor.black]
  UINavigationBar.appearance().largeTitleTextAttributes
    = [.foregroundColor : UIColor.black]
}
```

#### Localization
SwiftUI không còn property text nữa, muốn show text ta phải dùng Text view.
Ví dụ, label của button

```swift
Button {
    // Action.
} label: {
    Text(“Cancel”)
}
```

Do đó, để localize ta phải thực hiện lúc init Text.

#### Consistency giữa các Release
Hiện giờ, SwiftUI vẫn chưa ổn định, ví dụ, từ iOS 13 (Swift 1.0) lên iOS 14 (SwiftUI 2.0), tables được show lên hoàn toàn khác biệt (có thể tham khảo thêm: [Link](https://stackoverflow.com/questions/63938471/swiftui-ios14-navigationview-list-wont-fill-space)).
Do đó, nhiều khả năng SwiftUI 3.0 sẽ lại làm break layout lần nữa.

#### Life cycle
SwiftUI 2.0 đã có life cycle riêng, không cần phải dùng đến Life Cycle của AppDelegate.

#### View Debugging
Gần như ta không cần phải dùng đến View Debugging nữa vì SwiftUI đã có hỗ trợ Preview Canvas.