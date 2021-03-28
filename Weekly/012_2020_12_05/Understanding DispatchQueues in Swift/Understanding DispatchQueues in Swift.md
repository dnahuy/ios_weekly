[Original Link](https://betterprogramming.pub/understanding-dispatchqueues-2eb72ba965f4)

# Understanding DispatchQueues in Swift
## Introduction
Bài viết trình bày về __Process__ và __Thread__, sau đó tác giả tập trung phân tích về các đặc điểm và những vấn đề liên quan đến DispatchQueues.

## Process
Có thể hiểu Process như là 1 running program, app của chúng ta là 1 process, Safari là 1 process, Slack là 1 process, v.v…
Nó chứa 1 list các instructions (code của chúng ta ở Assembly format) và nó nằm ở trên disk cho đến khi user muốn run nó. OS sau đó sẽ load process vào memory, start 1 instruction pointer để cho chúng ta biết được instruction nào của program đang được thực thi. CPU sẽ tuần tự thực thi các instruction cho đến khi kết thúc, terminate process.

Address space of a single-thread process
|- - - - - - - - - - - - - - - - - - - - - - - - - - |
|                    Instructions                    |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|                    Global Data                     |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|           malloc'd data (Reference Types)          |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
| Nothing (Stack and malloc'd data grow towards here)|
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|   Stack (Value Types (if possible), args, returns) |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -

Mỗi process sẽ có 1 phần physical memory dành riêng cho nó, addresses không được share với các process khác.

## Cách CPU run nhiều process cùng lúc
Câu trả lời là nó không thể. Một CPU đơn giản là không thể làm 2 thứ cùng 1 thời điểm. Có thể khác biệt đôi chút với CPU có multiple core, nhưng về cơ bản thì vẫn là không đổi. Cái thực sự xảy ra chính là CPU sẽ excute gì đó  của Process 1, sau đó excute gì đó của Process 2 và tiếp tục. OS sẽ lưu lại bất cứ gì mà CPU đang làm cho 1 process cụ thể trong memory (dưới dạng registers và pointers), sau đó sẽ quyết định process nào tiếp theo sẽ được excute, khôi phục lại cái đang làm (registers và pointers) của process đó, và CPU tiếp tục run process đó. Quá trình này gọi là __context switch__ và nó diễn ra rất nhanh nên làm cho ta nghĩ là thực sụ run nhiều process cùng lúc.

## Thread

Address space of a multi-threaded process
|- - - - - - - - - - - - - - - - - - - - - - - - - - |
|                    Instructions                    |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|                    Global Data                     |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|           malloc'd data (Reference Types)          |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
| Nothing (Stack and malloc'd data grow towards here)|
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|                 Stack of Thread 2                  |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -
|                 Stack of Thread 1                  |
|- - - - - - - - - - - - - - - - - - - - - - - - - - -

Một process có thể là single-thread process hoặc multi-thread process.
Về cơ bản, có thể xem thread thực sự rất giống với process ngoại trừ 1 điểm khác biệt: chúng share chung address space (của process) và do đó có thể access same data.
Cũng như process, CPU không thể run 2 thread cùng lúc và cũng như process, thread cũng sẽ có context switch.

## iOS main thread
iOS app sẽ có 1 vài thread, main thread về cơ bản là starting point của excution. Mai thread execute 1 loop mỗi frame (RunLoop), draw current screen nếu cần, handle UI events (chẳng hạn như touch), và execute nội dung của DispatchQueues.main. Nó có priority rất cao, được execute gần như ngay lập tức. Tuy nhiên, chúng ta không nên handle mọi thứ trong main thread vì sẽ làm cho main thread phải xử lý quá nhiều task gây delay update UI.

## iOS background thread và DispatchQueues 
Background thread là bất cứ thread nào không phải main thread. Trong iOS, cách dễ nhất để spawning 1 background thread là dùng DispatchQueues.
DispatchQueues không phải là thread, nó giúp tự động tạo hoặc reuse thread từ thread pool khi cần.

## Background Queues Priorities
Bằng cách gán QoS cho 1 action, ta có thể chỉ định tầm quan trọng của nó và system sẽ prioritize nó và schedule nó tương ứng.
Qos:
* __UserInteractive:__ for work phải được processed ngay lập tức
* __UserInitiated:__ for work gần như đồng thời (1 vài second hoặc ít hơn)
* __Utility:__ for work có thể take time, ví dụ API call
* __Background:__ for work take rất nhiều time.

## Ảnh hưởng của các QoS level khác nhau

#### Heavy task trên main thread
```swift
@IBAction func actionOne(_ sender: Any) {
    //We are already in the main thread, but we will use a dispatch operation
    //to see how long it takes for the task to begin.
    DispatchQueue.main.async { [unowned self] in
        self.timeIntensiveTask()
    }
}
```
Take khoảng 5 giây, __toàn bộ screen bị freeze__

#### Heavy task trên UserInitiated QoS thread
```swift
@IBAction func actionOne(_ sender: Any) {
    DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
        self.timeIntensiveTask()
    }
}
```
__No screen freeze__ và nó cũng take khoảng 5 giây để complete

#### Heavy task trên Background QoS thread
```swift
@IBAction func actionOne(_ sender: Any) {
    DispatchQueue.global(qos: .background).async { [unowned self] in
        self.timeIntensiveTask()
    }
}
```
Cũng gần giống UserInitated QoS, tuy nhiên nó take some time để start và cần khoảng __10 giây__ để end.

## Sync và Async
