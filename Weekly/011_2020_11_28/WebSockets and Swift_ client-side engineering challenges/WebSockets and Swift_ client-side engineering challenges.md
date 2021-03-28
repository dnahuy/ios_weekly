[Original Link](https://www.ably.io/topic/websockets-swift)

# WebSockets and Swift: client-side engineering challenges
## Introduction
Bài viết mô tả về các engineering challenge khi implement client-side WebSockets cho Swift.

## A brief overview
Apple có hỗ trợ [URLSessionWebSocketTask](https://developer.apple.com/documentation/foundation/urlsessionwebsockettask) và low-level network programming [NWProtocolWebSocket](https://developer.apple.com/documentation/network/nwprotocolwebsocket)
Raw implementation của WebSocket thường không đủ cho realtime app. Chúng ta có thể dùng các open-source library như SocketRocket hoặc Starscream.
Những library này có thể cung cấp thêm vài additonal functionality, chẳng hạn như TLS hoặc proxy support.
Tuy nhiên, những library này cũng chỉ là wrapper của WebSocket client, chúng không cung cấp functionality on top.
Một protocol on top thường được dùng, hỗ trợ cho enricher functionality chẳng hạn như Pub/Sub. 

```swift
let ably = ARTRealtime(key: "ABLY_API_KEY")
let channel = ably.channels.get("test")

// Publish a message to the test channel
channel.publish("greeting", data: "hello")

let ably = ARTRealtime(key: "ABLY_API_KEY")
let channel = ably.channels.get("test")

// Subscribe to messages on channel
channel.subscribe("greeting") { message in
  print("\(message.data)")
}
```

Bên trên là 1 protocol cho Pub/Sub được dùng on top WebSockets. Mặc dù communication được thông qua WebSockets, underlying WebSockets protocol đã được “ẩn” khỏi developer.
Bạn có thể quyết định chọn bất kỳ WebSocket-based protocol nào mà hỗ trợ Swift. Tuy nhiên, dù bạn chọn cái nào, bạn cũng phải consider đến những challenges sẽ gặp.

## Những cái cần consider
#### Authentication
##### Basic authentication:
```
wss://realtime.ably.com/?key=MY_API_KEY&format=json&heartbeats=true&v=1.1&lib=js-web-1.2.1
```
Tuy nhiên cách này có nhiều nhược điểm.

#####  Token-based authentication:
Cách này hiệu quả và secure hơn so với Basic Authentication và tác giả đề xuất sử dụng __JSON Web Token (JWT).__
Đối với cách này thì chúng ta sẽ gặp vài vấn đề cần giải quyết
* Handle token privileges và permissions như thế nào?
* Set TTL (time to live) như thế nào
* Renew token như thế nào?
* Tokens được send như thế nào?

#### Network compability và fallback transports
Sẽ có vài networking issues mà chúng ta có thể gặp phải. Ví dụ như proxy traversal. Một vài serves và corporate firewalls sẽ block WebSockets connection. Port 80 và 443 là standard ports cho Web Access và chúng cũng support cho WebSocket. Port 80 được dùng cho các insecure connection vì vậy nếu có thể hãy dùng port 443. Nó secure hơn và ngăn chặn proxies inspecting connections.
Nếu không thể dùng port 443 hoặc chúng ta biết trước rằng client sẽ connect từ trong corporate firewall, chúng ta cần phải support fallback transports chẳng hạn như XHR steaming, XHR polling hoặc JSONP polling.

#### Device power và heartbeats
WebSocket connection là persistent, nó sẽ tốn pin để nó có thể active. Càng nhiều hearbeats thì pin sẽ càng bị hao nhiều. Tác giả có giới thiệu 1 cách khác trên mobile bằng cách sử dụng Push Notification của OS. Với cách tiếp cận này, chúng ta có thể không cần duy trì WebSocket connection active. App có thể được wake up khi Server send Push Notification.
Tuy nhiên Push Notification có nhược điểm là nó không cung cấp Quality of Service guarantee, ngoài ra nó còn có độ trễ và không có thứ tự.
Do đó, quyết định nên dùng hearbeat hay push notifcation sẽ tuỳ vào system requirement và use cases.

#### Handling reconnection và continuity
Đối với mobile device thường có thể sẽ gặp tình huống là thay đổi network condition. Device có thể switch từ Mobile Data Network sang Wifi hoặc phải trải qua sự cố mạng bị đứt quãng. Khi đó yêu cầu WebSocket connection phải được re-established.
Nếu chúng ta bắt buộc phải resuming 1 stream chính xác ngay tại điểm mà nó bị đứt quãng, chúng ta phải implement history/persisted data.
Có 1 vài thứ mà chúng ta sẽ cần phải lưu tâm:
* Caching messages in front-end memory
* Moving data to persistent storage
* Resuming a stream
* Backoff mechanism
