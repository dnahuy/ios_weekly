[Original Link](https://useyourloaf.com/blog/widgetkit-for-ios-getting-started/)

# WidgetKit for iOS - Getting Started
## Introduction
Bài viết hướng dẫn tạo ra 1 Widget đơn giản cho iOS

## Tạo ra Widget Extension
Trong XCode ta tạo ra 1 Widget Extension. Trong quá trình tạo sẽ có 1 checkbox là “Include Configuration Intent”, tạm thời để cho đơn giản ta sẽ uncheck nó, tức là ta sẽ chỉ dùng Static Configuration.

## Các thành phần chính của Widget
1 Widget sẽ có 3 thành phần chính

#### Configuration
Static (user không thể configurable) hoặc Intent (cho phép user có thể configurable). Luôn bao gồm 3 phần: __unique identifier (kind), timeline provider và content closure.__ Sử dụng modifier để set display name, description, supported widget size và background network handler

#### Timeline provider
Cung cấp timestamped entry 

#### Content closure
Nhận vào timeline entry và return SwiftUI View

## Static Configuration
```swift
StaticConfiguration(kind:, provider:, content:)
```
1. __kind:__ unique string identifier
2. __provider:__ cung cấp 1 array of timeline entries để WidgetKit display lên
3. __content:__ 1 closure nhận vào 1 timeline entry và return 1 SwiftUI View

## Timeline Entry
TimelineEntry là 1 protocol có chưa Date
```swift
protocol TimelineEntry {
    var date: Date { get }
}
```
## Timeline Provider
TimelineProvider có 3 protocol
```swift
protocol TimelineProvider {
    associatedtype Entry : TimelineEntry

    func placeholder(in context: Context) -> CountryEntry
    func getSnapshot(in context: Context, completion: @escaping (Self.Entry) -> Void)
    func getTimeline(in context: Context, completion: @escaping (Timeline<Self.Entry>) -> Void)
}
```
WidgetKit sẽ gọi hàm getTimeline để get các timeline entries cho hiện tại, và optionally, cho tương lai để widget update content của nó.

WidgetKit sẽ có 1 refresh policy để biết khi nào cần gọi getTimeline
* __atEnd:__ sau date của last entry trong timeline
* __after(Date):__ sau 1 date trong tương lai
* __never:__ WidgetKit sẽ không tự động request timeline từ Widget. App phải chủ động báo cho WidgetKit request 1 timeline mới.

## SwiftUI View
Content cần hiện lên của Widget, được return từ content closure của Configuration (nhận vào 1 timeline entry và return 1 View).

## Widget Previews
Ví dụ:
```swift
struct CountryWidgetPreviews: PreviewProvider {
  static var previews: some View {
    CountryView(country: Country.uk)
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
```
## User Interaction
Khi user tap vào Widget, sytem sẽ launch app. Ta có thể pass 1 url cho app bằng cách dùng widgetURL modifier

Ví dụ:
```swift
CountryView(country: country)
.widgetURL(country.url)
```
Trong app, ta có thể handle URL bằng
* SwiftUI: ___onOpenURL(perform:)___
* UIKit: ___application(_:open:options:)__

## Requesting a reload
App có thể chủ động make WidgetKit request 1  new timeline bằng cách dùng WidgetCenter
```swift
// Reload single widget
WidgetCenter.shared.reloadTimelines(ofKind: "CountryWidget")
```