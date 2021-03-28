[Original Link](https://medium.com/swlh/building-your-own-crash-report-in-swift-think-twice-before-doing-it-795ee7e23ee8)

# Building Your Own Crash Report in Swift. Think Twice Before Doing It.
## Introduction
Bài viết này tác giả trình bày những khó khăn mà ta sẽ gặp phải nếu ta muốn tự build 1 crash report.
Việc build 1 crash report nghe có vẻ đơn giản nhưng nó sẽ đòi hỏi rất nhiều kiến thức không dễ để thành thục chẳng hạn như __threading, concurrency, memory management, v.v…__

## Intercepting NSExceptions
Ta có thể đặt exception handler trong __didFinishLaunchingWithOptions__
```swift
NSSetUncaughtExceptionHandler { exception in
   print(exception)
}
```
Tuy nhiên, đoạn code trên chỉ có thể catch được exception trong khi có rất nhiều crash không liên quan đến exception. Ví dụ, Swift không dùng exeption mà nó sẽ thrown Error.
Để có thể cho ra 1 crash report đủ tốt, chúng ta phải tìm hiểu và phân tích toàn bộ __stack trace__, tìm thông tin mà chúng ta muốn và translate nó thành 1 cái gì đó mà developers có thể thực sự hiểu.
Data trong stack trace sẽ cho ta biết cái gì đã xảy ra nhưng không phải là tại sao nó xảy ra.

## Code (xử lý để tạo crash report) sẽ phải chạy trên 1 crashed process
Sẽ là rất không an toàn và không reliable khi phải run code trong tình huống này vì process đã ở vào trạng thái __undefined__. Sẽ không bảo đảm 100% rằng code sẽ chạy mà không gặp vấn đề gì.

## Handling signals
Implement cách handle signals trong stack trace để catch được crash. Có 2 cách
* __UNIX signals:__ Thường các developers sẽ quen thuộc với UNIX signals, tuy nhiên có 1 vài event crash sẽ không được translate trực tiếp đến UNIX signals
* __match exception handler:__ cơ chế error handling mặc định của Apple Crash Reporter. Đây là 1 good option nhưng bù lại nó khá phức tạp để hiểu.

## Reading memory
Scan memory address ở undefined state có thể gây ra unexpected behavior. Trong trường hợp mà có unexpected xảy ra, nó không chỉ ảnh hưởng đến code của chúng ta mà còn làm cho Apple Crash Reporter hoạt động không đúng.

## Symbolication và Stack Unwinding
Giả sử rằng chúng ta đã giải quyết được tất cả các vấn đề ở trên và chúng ta có thể duyệt qua stack trace. Nhưng chúng ta sẽ nhận thấy rằng những thông tin tìm thấy sẽ ở dạng không thể hiểu được.
Nguyên nhân là do chúng ta sẽ tìm thấy address liên quan tới crash chứ không phải là 1 string mô tả cái gì đã xảy ra.
Để có thể get được actual function calls, chúng ta cần phải áp dụng __Symbolication__ vào addresses.
Ngoài ra, còn có những thứ khác bên cạnh function calls trong stack trace. Toàn bộ quá trình này được gọi là __Stack Unwinding__.