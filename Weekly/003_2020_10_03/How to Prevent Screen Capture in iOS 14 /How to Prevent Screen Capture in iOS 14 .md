[Original Link](https://betterprogramming.pub/how-to-prevent-screen-capture-at-ios-14-1f01173c31c0)

# How to Prevent Screen Capture in iOS 14
## Introduction
iOS 14 cho phép tap-for-screenshot bằng cách double hay tripple tap vào mặt sau của điện thoại 

## Ngăn screen recording
```swift
UIScreen.capturedDidChangeNotification
```
Chúng ta có thể bắt được cái event này và tiến hành các thao tác như ẩn view hoặc show 1 blank cover

## Ngăn screenshot
iOS không có cách nào ngăn được việc screenshot nhưng mình có thể detect khi screenshot xảy ra
và delete ảnh đã lưu
```swift
UIApplication.userDidTakeScreenshotNotification
```