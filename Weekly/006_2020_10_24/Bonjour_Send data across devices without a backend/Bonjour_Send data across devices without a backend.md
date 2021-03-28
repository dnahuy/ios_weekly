[Original Link](https://itnext.io/bonjour-share-data-across-devices-without-a-backend-36faee520e14)

# Bonjour: Network Discoverability But Easy
## Introduction
Bài viết giới thiệu về cách dùng __Bonjour__ (1 __ZeroConf networking__ của Apple) để có thể giúp các iOS device trong cùng 1 local network thấy nhau và connect với nhau thông qua socket.

## Tìm IP của các device
Hoặc là manually input IP address của receiving phone. Hoặc scan list các device và pick cái muốn. Tuy nhiên, chúng ta có thể dùng ZeroConf. Khác biệt giữa ZeroConf và scan devices là tự động. Thay vì tìm tất cả devices chúng ta chỉ cần tìm các devices mà chúng ta muốn tìm và kết nối.

## Bonjour
```swift
let service = NetService(
    domain: "",
    type: "_examplebonjour._tcp.",
    name: UIDevice.current.name,
    port: 52177)
service.publish()
```

```swift
let serviceBrowser = NetServiceBrowser()
serviceBrowser.delegate = self
serviceBrowser.searchForServices(
    ofType: "_examplebonjour._tcp.",
    inDomain: "")
```