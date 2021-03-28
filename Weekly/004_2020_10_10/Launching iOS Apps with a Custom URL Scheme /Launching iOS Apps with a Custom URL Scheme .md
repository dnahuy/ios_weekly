[Original Link](https://useyourloaf.com/blog/launching-ios-apps-with-a-custom-url-scheme)

# Launching iOS Apps with a Custom URL Scheme
## Introduction
Mở app từ custom URL scheme.

## Mở trên device
Có thể lưu url trên Notes rồi click để mở. 

## Share từ Desktop Safari đến iOS simulator
Nhập custom url trên Safari address bar -> chọn Share -> Simulator

## Launch từ command line
```sh
xcrun simctl openurl booted facts://country/1149361
```
## Launch bằng Debugger Attached