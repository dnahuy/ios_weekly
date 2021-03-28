[Original Link](https://suelan.github.io/2021/02/13/20210213-dive-into-runloop-ios/)

# Dive into CFRunLoop

## Introduction
Bài viết tìm hiểu về CFRunLoop trong iOS và cách nó được sử dụng trong  __Matrix__,  là 1 framework của __Tencent__ phát triển dùng để __monitor app performance metrics.__

## RunLoop
Dùng để giữ cho Thread keep alive và xử lý event. RunLoop giữ cho thread busy khi có work để làm và để thread sleep khi không có gì.
Pseudo code
```javascript
function loop
    initialize()
    while message != quit
        message := get_next_message()
        process_message(message)
    end while
end function
```

Cụ thể:
```javascript
waiting events -> receive events -> handle events
```
Cho đến khi gặp exit conditions.

RunLoop có thể handle các events:
* User input devices
* Port objects
* Network connections
* Periodic hoặc time-delayed
* Asynchronous callbacks

Mỗi thread sẽ có chính xác 1 RunLoop đi kèm. Apple cung cấp 2 API để ta get RunLoop
1. __CFRunLoopGetMain():__ CFRunLoop của Main thread
2. __CFRunLoopGetCurrent():__ CFRunLoop của current thread


## RunLoop Mode
Bao gồm 1 tập các Sources và Timers được monitored và 1 tập các Observers sẽ được notified. Khi RunLoop run, chỉ những sources ứng với mode đang được chọn mới được monitored và được phép deliver Events

## Input sources
##### Port-based input source
* Monitor Mach ports
* Được signal tự động bởi Kernel

##### Custom input source
* Monitor custom sources của các event
* Phải được signal manually từ thread khác (___CFRunLoopSourceSignal(_:)__) khi có event

##### Cocoa perform selector sources
Ngoài port-based input source, Cocoa có định nghĩa thêm 1 custom input source cho phép perform 1 selector trên any thread. Nhưng không như port-based input source, perform selector source sẽ remove chính nó khỏi RunLoop sau khi perform selector. Khi perform selector trên 1 thread khác, target thread phải có 1 active run loop.

## CFRunLoopTimer
Là 1 run loop source mà sẽ chỉ kích hoạt tại 1 thời điểm đặt trước trong tương lai. Có thể được kích hoạt 1 lần duy nhất hoặc được lặp lại theo từng fixed interval. RunLoop Mode mà Timer được add vào phải đang run thì Timer mới kích hoạt khi đến thời điểm.

## RunLoop Observer
Ta có thể đăng ký Observer với RunLoop để được notified tại 1 điểm nào đó trong quá trình thực thi.
Ví dụ:
* Entrance vào RunLoop
* Khi RunLoop chuẩn bị process 1 timer
* Khi RunLoop chuẩn bị process 1 input source
* Khi RunLoop chuẩn bị sleep
* Khi RunLoop được wake up nhưng trước khi nó process event đã wake up nó.
* Exit khỏi RunLoop

```objc
CFRunLoopObserverRef runloopObserver = CFRunLoopObserverCreateWithHandler(
    kCFAllocatorDefault,
    kCFRunLoopBeforeWaiting,
    YES,
    0,
    ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
   // handler code here
});
   
CFRunLoopAddObserver(
    CFRunLoopGetMain(),
    runloopObserver,
    kCFRunLoopDefaultMode);
```

## Tencent Matrix App Performance Monitoring
Tencent Matrix có sử dụng Run Loop notifications để record timestamp khi notifications được sent