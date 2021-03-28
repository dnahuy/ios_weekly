[Original Link](https://betterprogramming.pub/launch-screens-in-xcode-all-the-options-explained-7a7a7992f535)

# Launch Screens in Xcode: All the Options Explained
## Introduction
Bài viết giới thiệu về lịch sử phát triển của LaunchScreen và các options hiện tại để custom LaunchScreen
LaunchScreen xuất hiện khi start app và giúp cho user cảm thấy rằng app nhanh và responsive.

## Lịch sử của LaunchScreen
Trước iOS 6, option duy nhất là dùng static image trong asset catalog. iOS 8 đi cùng với XCode 6 cho phép dùng storyboard thay vì static image. Tuy nhiên việc dynamic custom LaunchScreen vẫn là không thể và LaunchScreen bị cache rất lâu.
XCode 12 và iOS 14 đã improve LaunScreen.

## Guidelines
* Hạn chế dùng text vì localization không được.
* Bất cử ảnh nào được dùng cũng nên scale well trên những device size khác nhau.
* LaunchScreen nên giống nhất có thể với first screen của app.

## Clear cache trong quá trình dev
Trước đây, trong quá trình dev chúng ta thường gặp tình trạng đã chỉnh sửa LaunchScreen storyboard rồi nhưng nó không được update. Nguyên nhân là do iOS cache các loading views như image để tăng performance.
* Clean build folder
* Remove app và reinstall
* Reset simulator

Ngoài ra còn có 1 trick nhỏ đã được test trên iOS 13

```swift
public extension UIApplication {

    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }
}
```

## Add sleep để delay app launch
Đôi khi launch screen chỉ hiện lên chớp nhoáng là app đã launch xong first screen. Điều này khiến ta khó kiểm tra xem launch screen đã hiện đúng hay chưa. Ta có thể config thêm cho riêng môi trường debug để delay app launch.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    try! FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")

    do {
        sleep(2)
    }

    return true
}
```

## Sử dụng Storyboard

## Sử dụng plist config
Trong tương lai sẽ thay thế cho việc dùng storyboard khi SwiftUI đã thay thế cho storyboard và UIKit.
Remove key __UILaunchStoryboardName__
Thêm key __UILaunchScreen__. Trong Dictionary này, ta có thể set background image và color. Cả 2 được configure trong assets catalog

## Configure launch screen theo URL scheme
Option mới trong XCode 12, cho phép configure loading screen khác nhau theo từng URL scheme deep link (Custom URL Scheme).
Trong info plist chúng ta có thể configure 1 default launch screen và alternative launch screen cho URL mà ta muốn custom riêng.
