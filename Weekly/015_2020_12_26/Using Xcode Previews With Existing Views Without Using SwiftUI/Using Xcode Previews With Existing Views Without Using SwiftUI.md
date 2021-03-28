[Original Link](https://betterprogramming.pub/using-xcode-previews-with-existing-views-without-using-swiftui-a8dae93ecd23)

# Using Xcode Previews With Existing Views Without Using SwiftUI
## Introduction
Bài viết hướng dẫn cách có thể dùng chức năng Preview của XCode cho cả UIKit View chứ không chỉ SwiftUI View mới có.

Ta set lại Deployment Target là iOS 13.0. Đồng thời, ta thêm vào đoạn code sau

```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MyViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!.view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct MyViewViewController_Preview: PreviewProvider {
    static var previews: some View {
        MyViewRepresentable()
    }
}
#endif
```

Hàm __makeUIView__ sẽ trả về UIKit View mà ta muốn Preview trong XCode
