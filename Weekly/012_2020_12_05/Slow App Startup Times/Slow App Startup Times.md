[Original Link](https://useyourloaf.com/blog/slow-app-startup-times/)

# Slow App Startup Times
## Introduction
Bài viết trình bày về những case có thể làm chậm việc launch app và cách chúng ta có thể giải quyết

## Pre-main time
Nhiều thứ xảy ra trước khi system excute hàm __main()__ và gọi các delegate như __applicationWillFinishLaunching()__. Từ iOS 10, Apple cho phép xuất ra output của quá trình launch bằng cách enable __DYLD_PRINT_STATISTICS__

#### dylib loading time
Để tăng tốc dylib loading, chúng ta hạn chế sử dụng dylib hoặc chúng ta có thể merge chúng lại với nhau để số lượng dylib ít lại.

#### Rebase/binding time
App với nhiều Objective-C classes, selectors, categories có thể làm tăng launch time. Sử dụng Swift Structs nói chung sẽ nhanh hơn.

#### ObjC setup time
Objective-C runtime cần 1 vài setup cho class registration, category registration và selector uniquing. Bất cứ improvements nào áp dụng cho Rebase/binding time cũng sẽ được áp dụng cho setup time.

#### initializer time
Nếu đang sử dụng Objective-C +load method, hãy thay bằng +initialise

## Loading Frameworks sẽ tốn time
