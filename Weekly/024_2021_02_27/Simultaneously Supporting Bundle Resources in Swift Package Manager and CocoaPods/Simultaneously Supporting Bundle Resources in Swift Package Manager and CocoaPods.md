[Original Link](https://blog.sabintsev.com/simultaneously-supporting-bundle-resources-in-swift-package-manager-and-cocoapods-3fa35f4bce4e)

# Simultaneously Supporting Bundle Resources in Swift Package Manager and CocoaPods

## Giới thiệu
Bài viết giới thiệu về cách sử dụng Bundle Resources trong SPM. Từ SPM 5.3, chúng ta đã có thể bundle resources. 
Thường để sử dụng Bundle, chúng ta sẽ làm như sau:

```swift
Bundle(for: ClassInFramework.self).path(forResource: NameOfBundleInFramework, ofType: "bundle")
```

Nếu Framework của chúng ta được install bằng CocoaPods thì câu lệnh trên sẽ chạy bình thường.  Tuy nhiên, nếu framework được cài bằng SPM thì câu lệnh sẽ return về nil. Lý do của việc này là nếu được cài thông qua SPM, framework target sẽ được tự động gen ra 1 static property là module

```swift
extension Bundle {
    static let module = Bundle(path: "\(Bundle.main.bundlePath)/path/to/this/targets/resource/bundle")
}
```

Do đó, câu lệnh ban đầu sẽ cần phải sửa lại như sau:
```swift
Bundle.module.path(forResource: NameOfBundleInFramework, ofType: "bundle")
```

Lưu ý, static property này (__module__) không phải là public, và chỉ có thể được expose trong target đang sở hữu bundle resources. 
Do đó, các module khác hoặc sẽ có version Bundle.module của chính nó hoặc sẽ không có Bundle.module 

Vậy, trong framework của chúng ta làm sao chúng ta có thể biết được là nó có được cài bằng SPM hay không?  Ta có thể sử dụng 1 __preprocessor__ tên là __SWIFT_PACKAGE__ để phân biệt
