[Original Link](https://pspdfkit.com/blog/2021/advances-in-xcframeworks/)

# Advances in XCFrameworks

## Giới thiệu
Bài viết giới thiệu về những cải tiến và tính năng mới của xcframeworks trong XCode 12 và iOS 14

## Swift Packages đã hỗ trợ Binary Framework
SPM giờ đã cho phép distribute binary framework.

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PSPDFKit",
    products: [
        .library(
            name: "PSPDFKit",
            targets: ["PSPDFKit", "PSPDFKitUI"]),
    ],
    targets: [
        .binaryTarget(
            name: "PSPDFKit",
            url: "https://customers.pspdfkit.com/pspdfkit/xcframework/10.0.0.zip",
            checksum: "bfb412ada4d291e22542c2d06b3e9f811616fb043fbd12660b0108541eb33a3c"),
        .binaryTarget(
            name: "PSPDFKitUI",
            url: "https://customers.pspdfkit.com/pspdfkitui/xcframework/10.0.0.zip",
            checksum: "4903f4b7e753ac4760a827a72d7ed836a29e1700218ddfaa4e1f70814bd6f085"),
    ]
)
```
Ở targets, ta sẽ chọn là __.binaryTarget__

## Tự động support Apple Silicon thông qua Fat Binaries
Từ XCode 12, Apple đã support Apple Silicon cho iOS Simulator và Mac Catalyst thông qua fat binaries. Riêng với iOS device binary vẫn chỉ chứa arm64

```sh
# Device slice.
xcodebuild archive -workspace 'MyFramework.xcworkspace' -scheme 'MyFramework.framework' -configuration Release -destination 'generic/platform=iOS' -archivePath '/path/to/archives/MyFramework.framework-iphoneos.xcarchive' SKIP_INSTALL=NO

# Simulator slice.
xcodebuild archive -workspace 'MyFramework.xcworkspace' -scheme 'MyFramework.framework' -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath '/path/to/archives/MyFramework.framework-iphonesimulator.xcarchive' SKIP_INSTALL=NO

# Mac Catalyst slice.
xcodebuild archive -workspace 'MyFramework.xcworkspace' -scheme 'MyFramework.framework' -configuration Release -destination 'platform=macOS,arch=x86_64,variant=Mac Catalyst' -archivePath '/path/to/archives/MyFramework.framework-catalyst.xcarchive' SKIP_INSTALL=NO
```

Ta có thể kiểm tra binary framework iOS Simulator bằng cách dùng lipo command
```sh
lipo -info /path/to/archives/MyFramework.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/MyFramework.framework/MyFramework
```

Output ra sẽ là:
```sh
Architectures in the fat file: /path/to/archives/MyFramework.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/MyFramework.framework/MyFramework are: x86_64 arm64
```

## Built-in support cho BCSymbolMaps và dSYMs
Trước XCode 12, Archive phase có generate ra debug symbols, tuy nhiên chúng lại không nằm trong final xcframework, vì thế cần thêm thao tác tích hợp để bảo đảm BCSymbolMaps và dSYMs được copy vào App archive.
Từ XCode 12, BCSymbolMaps và dSYMs sẽ tự động được add vào final xcframework, và XCode 12 sẽ tự động pick chúng trong quá trình archiving app.