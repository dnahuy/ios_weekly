[Original Link](https://www.appcoda.com/xcframework/)

# A Step by Step Guide on how to Create a XCFramework and Distribute it as a Swift package
## Introduction
Bài viết này tác giả hướng dẫn tạo các framework của iOS (cho cả device và simulator) và framework cho MacOS. Sau đó tác giả kết hợp tất cả lại (iphoneos, iphonesimulator và macos) để tạo thành 1 __universal framework__. Tác giả cũng minh hoạ việc sử dụng xcframework vừa tạo ra.

Phần của bài blog này khá hay. Trước XCode12 SwiftPM được dùng chủ yếu distribute open source. 
Từ XCode12, SwiftPM hỗ trợ thêm distribute binary framework. Tác giả minh hoạ việc distribute framework đã build theo 2 cách local và remote.

## Tạo ra xcframework
```sh
xcodebuild -create-xcframework \
-framework ./XIBLoadable-iOS.xcarchive/Products/Library/Frameworks/XIBLoadable_iOS.framework \
-framework ./XIBLoadable-Sim.xcarchive/Products/Library/Frameworks/XIBLoadable_iOS.framework \
-framework ./XIBLoadable-macOS.xcarchive/Products/Library/Frameworks/XIBLoadable_macOS.framework \
-output ./XIBLoadable.xcframework
```

## Sử dụng local SwiftPM
```swift
import PackageDescription

let package = Package(
   name: "XIBLoadablePackage",
   products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "XIBLoadablePackage",
            targets: ["XIBLoadable"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "XIBLoadable", path: "./Sources/XIBLoadable.xcframework")
    ]
)
```

## Sử dụng remote SwiftPM
```sh
swift package compute-checksum ../output/XIBLoadable.xcframework.zip

.binaryTarget(name: "XIBLoadable", url: "https://SERVER_URL/XIBLoadable.xcframework.zip", checksum: "8580a0031a90739830a613767150ab1a53644f6e745d6d16090429fbc0d7e7a4")
```
