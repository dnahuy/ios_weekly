[Original Link](https://medium.com/360learning-engineering/resolving-itms-90562-invalid-bundle-email-from-the-app-store-d4a1030418e5)

# Resolving “ITMS-90562: Invalid Bundle” email from App Store

## Introduction
Bài viết giới thiệu về 1 error mà tác giả gặp phải khi áp dụng __Modularization architect__. Error này liên quan tới __missing framework__ và chỉ được phát hiện khi upload build lên AppStore (tức là vẫn work well khi dev ở local).
Cần lưu ý: tác giả dùng Carthage cho Dependency Management.

## Transitive framework dependency
Có 3 module: A, B và C. Trong đó, A phụ thuộc vào B, B phụ thuộc vào C do đó A phụ thuộc gián tiếp vào C. A là main module, sẽ được archived và ship đến AppStore.
XCode work well với những dependencies như thế và khi app được compile thành công, sẽ không có bất kỳ missing framework nào ở runtime, trong suốt development hoặc testing.
Nhưng sau khi build được submit và xử lý bởi AppStore, nhiều khả năng ta sẽ gặp error: __“Invalid Bundle - One or more dynamic libraries that are referenced by your app are not present in the dylib search path”.__

## Missing frameworks
Ta cần get file .ipa của bản build đang gặp lỗi, unzip nó và sau đó show package content của Payload.
Để xem tất cả các framework được dùng, ta dùng câu lệnh sau:
```sh
otool -L app/Payload/App.app/App
```
Sẽ print ra full list của dependencies.
Sau đó ta mở folder __Frameworks__, là nơi chứa tất cả các frameworks được include và tìm xem sự khác biệt với danh sách đã được in ra bằng command otool.
Khi đã tìm thấy framework đang bị miss, ta có thể add nó vào App module như là direct dependency.
