[Original Link](https://levelup.gitconnected.com/the-power-of-swift-web-assembly-part-1-fdfa4e9134ee)

# The power of Swift + Web Assembly (Part 1)
## Introduction
Bài viết hướng dẫn cách integrate Swift code vào trong Golang project bằng cách dùng WebAssembly. Chúng ta có thể tìm hiểu thêm về WebAssembly trong những bài blog khác

## WebAssembly
Trước đây, để phát triển WebApp, chúng ta chỉ cần biết HTML/CSS/Javascript, hiện giờ sẽ có thêm WebAssembly (file .wasm). Về cơ bản WebAssembly sẽ giúp Javascript có thể execute các code viết bằng ngôn ngữ khác (ví dụ C/C++, Swift, v.v…)

## Tools
Tác giả giới thiệu các tools cần dùng và cách install chúng.
__warmer:__ là 1 WebAssembly runtime cho phép load các wasm binaries (Swift) và communicate với supported host language (Go).

## Swift
Tác giả hướng dẫn tạo ra 1 Swift Package executable

## Go
Tạo ra 1 Go project đơn giản

## Integrate wasmer
Integrate wasmer vào trong Go application

## Tạo ra .wasm từ Swift
Generate ra .wasm binary từ Swift project bằng các tool đã cài ở trên.

## Start binary
Trong Go application, có 1 hàm _start, hàm này chỉ đơn giản là sẽ start binary (tương tự như khi gọi swift run)