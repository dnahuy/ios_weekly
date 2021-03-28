[Original Link](https://www.onswiftwings.com/posts/build-time-optimization-part1/)

# Xcode Build Time Optimization - Part 1
## Introduction
Bài viết giới thiệu về vài __settings__ ta có thể set để get các __build metrics__.

## 2 loại build
##### Clean build
##### Incremental build

## Đo build time
#### XCode build report
Ta có thể xem build time và log từ Report Navigator

#### XCode build timimg summary
```
Product -> Perform Action -> Build With Timing Summary
```
Chúng ta sẽ xem được chi tiết hơn về time của từng tasks.

#### Type check warning
```sh
-Xfrontend -warn-long-function-bodies = 100
-Xfrontend -warn-long-expression-type-checking = 100
```

#### Compiler diagnostic options
Ta có thể thêm các settings flag (__OTHER_SWIFT_FLAGS__) lúc build để xem rõ hơn về các build metrics

* ___-driver-time-compilation:___ high-level timing của các job mà driver execute
* ___-Xfrontend -debug-time-compilation:___ timers cho từng phase của frontend job execution
* ___-Xfrontend -debug-time-function-bodies:___ time spent typechecking của mọi hàm trong app.
* ___-Xfrontend -debug-time-expression-type-checking:___ time spent typechecking của mọi expression trong app

#### Target’s build times
__xcode-build-times-rendering__ là 1 tool giúp đơn giản hoá việc đo build time của các target và generate ra thành 1 chart.

#### Metric tổng hợp
XCLogParser là 1 tool giúp ta tổng hợp lại các metrics khác nhau và cung cấp thêm rất nhiều thông tin về build.

#### Automation
Ta có thể dùng CI để tự động hoá việc get các metrics daily.