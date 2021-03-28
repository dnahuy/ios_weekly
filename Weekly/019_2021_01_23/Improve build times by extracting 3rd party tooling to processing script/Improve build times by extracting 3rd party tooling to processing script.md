[Original Link](http://merowing.info/2021/01/improve-build-times-by-extracting-3rd-party-tooling-to-processing-script./)

# Improve build times by extracting 3rd party tooling to processing script.
## Introduction
Bài viết giới thiệu về cách improve build time bằng cách hạn chế bớt việc chạy các 3rd party tooling. Những tool này thật ra không cần phải luôn được run mỗi lần build.
Ví dụ: 
_SwiftLint, Sourcery, SwiftGen, SwiftFormat._

## Script
Để chạy các 3rd party tooling đó, chúng ta sẽ viết 1 đoạn script chạy với 2 mode
* fail-on-errors: bất cứ error nào cũng sẽ làm cho script exit với failure code. Mode này được dùng bởi CI / Precommit
* local: run manually bởi developer. Chúng ta sẽ không fail script và sẽ có thể add thêm 1 vài console coloring và extra debug information nếu cần.

## Pre-commit và CI
Ta có thể gắn script này vào pre-commit của CI để bảo đảm nó sẽ được chạy với mode fail-on-errors mỗi lần có commit và sẽ exit failure nếu có lỗi phát sinh.

