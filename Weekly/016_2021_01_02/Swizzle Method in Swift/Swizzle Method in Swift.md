[Original Link](https://medium.com/@m.delgiudice/swizzle-method-in-swift-8af664ffe77a)

# Swizzle Method in Swift
## Introduction
Bài viết hướng dẫn thực hiện swizzle method trong Swift

## Requirements
Ta chỉ có thể thực hiện swizzle trong Swift nếu thoải 2 điều:
* Class phải kế thừa NSObject
* Các func mà bạn muốn swizzle phải có dynamic attribute

## Ví dụ

```swift
extension UIViewController {
    @objc dynamic func _swizzled_viewWillAppear(_ animated: Bool) {
        _swizzled_viewWillAppear(animated)
    //do your stuffs
    }
    
    static func swizzleViewWillAppear() {
        let selector1 = #selector(UIViewController.viewWillAppear(_:))
        let selector2 = #selector(UIViewController._swizzled_viewWillAppear(_:))
        let originalMethod = class_getInstanceMethod(UIViewController.self, selector1)!
        let swizzleMethod = class_getInstanceMethod(UIViewController.self, selector2)!
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
}
```

Hàm __swizzleViewWillAppear__ thực hiện việc swizzle hàm __viewWillAppear()__ của UIViewController với hàm ___swizzled_viewWillAppear()__.
Để thực hiện swizzle, ta cần gọi hàm này.

```swift
UIViewController.swizzleViewWillAppear()
```