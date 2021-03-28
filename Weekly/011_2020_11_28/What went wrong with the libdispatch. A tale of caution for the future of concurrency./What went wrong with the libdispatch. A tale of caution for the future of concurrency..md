[Original Link](https://tclementdev.com/posts/what_went_wrong_with_the_libdispatch.html)

# What went wrong with the libdispatch. A tale of caution for the future of concurrency.
## Introduction
Bài viết này chia sẻ các nghiên cứu và trải nghiệm của tác giả về __libdispatch (Grand Central Dispatch).__ Những kinh nghiệm và những điều rút ra được thực sự rất đáng giá. Đây là 1 bài blog thực sự chất lượng.

## Good Times
libdispatch được Apple giới thiệu tại WWDC 2008 và tác giả khi đó đã rất thích thú. Libdispatch cùng với inline block syntax giúp cho việc thực hiện multithread rất dễ dàng và giúp tận dụng sức mạnh của các multicore machine.
Vào giai đoạn 2000-2008, các developer chỉ start multithread khi bắt buộc phải thế (ví dụ 1 long-running task làm chậm UI).
Apple đưa ra khái niệm về queue và bảo các developer rằng từ giờ nên ngừng suy nghĩ về thread mà hãy suy nghĩ về queue. Chúng ta chỉ cần submit task sẽ được thực hiện tuần tự hoặc đồng thời và libdispatch sẽ lo phần còn lại.
Nó sẽ tự động scale dựa trên available hardware. Queue rất rẻ và kỹ sư Apple tại WWDC đó cũng từng nói rằng chúng ta có thể có hàng ngàn queue.
_"islands of serialization in a sea of concurrency”:_ mỗi program component cần thread safety sẽ có 1 private serial queue của riêng nó và giữa các components với nhau thì dùng concurrent queues.

## Bad Times 
Tuy nhiên, mọi chuyện thực sự không tốt như Apple đã tuyên bố. Tác giả gặp vấn đề với thread explosion và tác giả đã rất ngạc nhiên vì đáng lẽ libdispatch phải tự động scale dựa trên available hardware. Đáng lẽ số lượng thread phải hơn kém chút ít so với số lượng core của máy. Tác giả đã email cho Apple và nhận được trả lời là hãy remove hoàn toàn synchronization point và chuyển hoàn toàn sang async.
Sự việc bắt đầu ngày càng trở nên tệ hơn vì 1 hàm gọi 1 hàm async sẽ không thể nào return kết quả mà không async chính nó (giống như completion block) nên đã gây ra toàn bộ chain phải chuyển sang async. Bắt đầu có những hàm hoàn toàn không có ý nghĩa gì để phải gọi nó theo kiểu async và việc async quá nhiều gây ra nhiều vấn đề khác nữa như heavy callback designers, code khó đọc. Điều tệ nhất chính là nó làm ảnh hưởng đến performance, việc có quá nhiều async small task và được liên tục dispatch lên các queue sẽ gây ra rất nhiều lãng phí resource.
Cuối cùng sau khi đã chuyển sang async rồi tác giả vẫn thấy rằng trong điều kiện bình thường vẫn còn 40 - 60 thread được running trên 1 máy 4 core. Một kỹ sư của Apple cũng đã tiết lộ rằng trong iOS 12, các deamons có performance tốt nhất lại là những cái chạy single-threaded.
___"strongly consider not writing async/concurrent code"___

## Interlude 
libdispatch vẫn rất hữu ích vì nó giúp giảm nhẹ gánh nặng về việc developer phải tự quản lý thread và tập trung hơn vào program design.

## Up to now
Tác giả đã tự tìm tòi và research ra được các [Tips](https://gist.github.com/tclementdev/6af616354912b0347cdf6db159c37057) có thể apply để giải quyết các vấn đề .
Ý định ban đầu của Apple về libdispatch cuối cùng đã không thành công. Mặc dù developer không phải lo về việc quản lý thread nhưng bù lại phải lo về cách sử dụng queue y như là đối với thread.
Developer cuối cùng vẫn chú ý và xem xét cẩn thận về multithreading cũng như program design chứ không phải là mọi heavy things đã được libdispatch giải quyết như Apple tuyên bố lúc đầu.

