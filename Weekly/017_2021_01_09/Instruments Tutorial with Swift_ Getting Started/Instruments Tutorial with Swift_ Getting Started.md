[Original Link](https://www.raywenderlich.com/16126261-instruments-tutorial-with-swift-getting-started)

# Instruments Tutorial with Swift: Getting Started
## Introduction
Bài viết hướng dẫn dùng Instruments để đo Performance của iOS app

## Time Profiler
Đối với Time Profiler, sau từng khoảng thời gian xác định, Instruments sẽ tạm dừng execution của app lại và lưu lại stack trace của từng running thread.

#### Call Tree
Show tổng thời gian excute các method trong app. Mỗi dòng là 1 method khác nhau mà execution path đã đi qua. Instruments tính xấp xỉ time của từng method bằng cách đếm số lần profiler dừng trong từng method.

Ngoài ra, khi click vào nút Call Tree, ta sẽ thấy 1 vài option sau đây trong việc hiển thị Call Tree detail
* Separate by State: Nhóm kết quả theo app’s lifecycle state
* Separate by Thread: Nhóm theo thread
* Invert Call Tree: sẽ show most recent frame trước trong stack tree
* Hide system libraries: chỉ hiện những symbols từ app
* Flatten Recursion: đối với những hàm đệ quỵ, chỉ show 1 entry thay vì show nhiều lần
* Top Functions: Total time trong 1 hàm là tổng của time trong hàm đó cũng như time của các hàm được gọi bởi hàm đó.

## Allocations 
Instrument này sẽ giúp ta tracking tất cả các object trong app và memory của chúng.

#### Mark Generation
Take a snapshot của heap memory. Ở phần Detail sẽ có cột Growth, cho phép ta xem heap memory đã tăng giảm như thế nào so với previous snapshot.

#### Simulating a Memory Warning
Take a snapshot của heap memory. Ở phần Detail sẽ có cột Growth, cho phép ta xem heap memory đã tăng giảm như thế nào so với previous snapshot.

## Strong Reference Cycles
Allocations Instrument cũng giúp ta detect Strong Reference Cycles. Ở góc trái dưới có 1 textbox, ta sẽ điền vào đó tên của App, nó sẽ giúp ta filter ra những category và memory tương ứng với những category đó (persistence hoặc transient).
Dựa vào persistence, ta có thể check được có object nào đang bị strong reference hay không. Ví dụ, 1 CustomViewController đáng lẽ sẽ phải bị deallocated nếu nó được pop khỏi NavigationViewController. Tuy nhiên, nếu persistence vẫn đang count nó tức là nó vẫn đang được reference mà chưa bị deallocated.