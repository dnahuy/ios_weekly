[Original Link](https://betterprogramming.pub/5-auto-layout-approaches-at-swift-b229cf396ee2)

# 5 Auto Layout Approaches in Swift
## Introduction
Bài viết giới thiệu về 5 cách tiếp cận để thực hiện Auto Layout trên iOS

## 1. Dùng NSLayoutConstraint
```swift
item1.attribute1 = multiplier × item2.attribute2 + constant
```
Đây là cách chúng ta vẫn hay xài bằng cách sử dụng các third party như SnapKit, Masonry

## 2. Dùng Visual Format Language
Cách thứ 2 là dùng Visual Format String grammar, cách này thì giúp chúng ta setup constraints đỡ “lằng nhằng” hơn so với NSLayoutConstraints, tuy nhiên nó cũng vẫn sẽ có những pitfalls của việc dùng string
```swift
    let verticalConstraints = NSLayoutConstraint.constraints(
        withVisualFormat: "V:[superView]-(<=0)-[view(100)]",
        options: .alignAllCenterX,
        metrics: nil,
        views: views
    )
```
## 3. Dùng AutoresizingMask
Autoresizing sẽ quyết định cách receiver resize chính nó khi bounds của superview change.
```swift
    subView.autoresizingMask = [
        .flexibleLeftMargin,
        .flexibleRightMargin,
        .flexibleTopMargin,
        .flexibleBottomMargin
    ]
```

## 4. Dùng NSLayoutAnchor
Dùng NSLayoutAnchor sẽ khắc phục phần nào nhược điểm phải viết những đoạn code dài và complex để tạo ra layout constraint. 
Về cơ bản chúng ta sẽ dựa chủ yếu trên các anchor properties (ví dụ, leading, trailing, top, bottom anchor) và add constraint mong muốn.
```swift
      let leadingConstraint = subview.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 8.0)
```

Hoặc ta có thể gom tất cả lại:  
```swift
    NSLayoutConstraint.activate([
        subView.heightAnchor.constraint(equalToConstant: 100),
        subView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        subView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    ])
```
## 5. Dùng instrinsicContentSize
Trong vài trường hợp, size của view sẽ dựa trên content mà nó đang chứa (ví dụ UILabel), ta có thể kết hợp size này với layout system.
Các constraint liên quan tới size của 1 view bất kỳ, khi đó auto layout system có thể dùng __instrinsicContentSize__ của view đó để tính toán tương ứng.
Ví dụ, ta constraint height của 1 view với height của 1 UILabel (có instrinsicContentSize dựa trên nội dung text mà label đang chứa).