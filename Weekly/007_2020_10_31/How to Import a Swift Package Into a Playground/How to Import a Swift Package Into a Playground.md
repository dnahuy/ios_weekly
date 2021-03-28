[Original Link](https://medium.com/better-programming/import-a-swift-package-into-a-playground-1bb650e196b0)

# How to Import a Swift Package Into a Playground
## Introduction
Bài viết hướng dẫn cách sử dụng Swift Package ngay trong Playground.

## Kéo và thả Package vào trong Workspace
```swift
import Algorithms

let seasons = ["winter", "spring", "summer", "fall"]

for (year, season) in product(1900...2020, seasons) {
    print(year, season)
}
```
Ví dụ minh hoạ sử dụng package [Algorithms](https://github.com/apple/swift-algorithms)