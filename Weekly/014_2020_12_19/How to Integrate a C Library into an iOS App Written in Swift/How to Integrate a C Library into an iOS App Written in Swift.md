[Original Link](https://medium.com/@distillerytech/how-to-integrate-a-c-library-into-an-ios-app-written-in-swift-ef92c0e0d42b)

# How to Integrate a C Library into an iOS App Written in Swift
## Introduction
Bài viết giới thiệu về quá trình tác giả integrate 1 C library vào trong 1 iOS Swift project. C library cần integrate ở đây là __libsignal__, 1 library về encryption. N

Nội dung chủ yếu gồm 2 phần, phần đầu tác giả mô tả cách sử dụng bằng cách add trực tiếp source files của library vào thẳng trong Swift project. 

Phần 2 tác giả trình bày cách thay vì sử dụng tiếp, ta có thể tạo 1 Cocoa Touch Framework chứa C library.

## Add trực tiếp
Cách này tương đối đơn giản, ta chỉ cần add toàn bộ source files của library vào trong project. Ta chỉ cần tạo ra 1 file module.map mà content của nó là các file header .h sẽ expose ra cho Swift project.
```swift
module SignalProtocol [system] {
header “src/signal_protocol.h”
export *
}
```
Thật ra quá trình không đơn giản như vậy, tác giả cũng đề cập đến các build error phát sinh (chủ yếu là do nested headers) nhưng về cơ bản, nguyên lý chung là ta sẽ dùng file __module.map__

## Wrap in Cocoa Touch Framework
Hơi khác với cách add trực tiếp, ta sẽ không thể sử dụng file module.map (Build Settings của framework project không có “Swift Compiler - Search Paths” section.
Các steps thực hiện như sau:
1. Tạo ra New Project (Cocoa Touch Framework)
2. Add source files
3. Select Headers to Expose
Mở “Build Phases”, “Headers” section, add các headers mà ta dự định sẽ expose ra, drag nó vào “Public” list.
4. Import headers
Add tất cả các headers đó vào trong main header của framework. Cái mà mặc định sẽ có tên là [framework_name].h và nằm ở root directory của framework.

```swift
#import “protocol.h”
```
Lưu ý: vì ta đã add tất cả header vào trong project file, ta chỉ cần sử dụng file name mà không cần phải xác định whole path.