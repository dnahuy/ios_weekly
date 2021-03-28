[Original Link](https://medium.com/@artrmz/how-to-manage-toolchains-in-xcode-5b30f41ca691)

# How to Manage Toolchains in Xcode
## Introduction
Bài viết hướng dẫn cách dùng 1 toolchains khác để thử nghiệm feature mới của Swift thay vì chỉ dùng default sẵn có trong XCode

## Cài đặt toolchains
Download snapshot từ official website của Swift, sau đó ta có thể cài toolchains vào 1 trong 2 chỗ

* ___/Library/Developer/Toolchains:___ available cho tất cả user
* ___~/Library/Developer/Toolchains:___ chỉ available cho user đó


Sau đó, trong XCode ta đã có thể chọn dùng toolchains này thay vì toolchains mặc định.

## Custom toolchains từ command line
Cách trên chỉ có thể sử dụng toolchains mới trong XCode, xcodebuild hoặc fastlane vẫn đang dùng default toolchains.
Để dùng toolchains mới, ta phải gọi xcrun à xcodebuild với flag là toolchain.

```sh
xcodebuild -toolchain NAME
xcrun — toolchain NAME
```

Với NAME hoặc là identifier hoặc là tên của toolchains
