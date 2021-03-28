[Original Link](https://betterprogramming.pub/urlsession-common-pitfalls-with-background-download-upload-tasks-8d479a1698fe)

# URLSession: Common Pitfalls With Background Download and Upload
## Introduction
Bài viết đề cập đến những sai lầm thường mắc phải khi dùng URLSession cho việc download và upload ở background

## URLSessionConfiguration cần 1 unique identifier
Nếu chúng ta trigger background download/upload từ app extension, khi host app được relaunched và method handler được gọi.
```swift
func application(
    application: UIApplication,
    handleEventsForBackgroundURLSession identifier: String,
    completionHandler:() -> Void
) {
    let config = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(identifier)
    let session = NSURLSession(
        configuration: config,
        delegate: self,
        delegateQueue: NSOperationQueue.mainQueue())
    session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) -> Void in
      // yay! you have your tasks!
    }
}
```

Chúng ta phải sử dụng identifier được pass vào để tái tạo lại session như lúc nó được tạo ra ở extension. Do đó, lúc tạo ra URLSession, chúng ta bắt buộc phải cung cấp identifier là unique.

## Bundle-based identifier
Để bảo đảm identifier ở các extension là unique, ta có thể dựa vào bundle

```swift
let appBundleName = Bundle.main.bundleURL.lastPathComponent.lowercased().replacingOccurrences(of: " ", with: ".")
let sessionIdentifier: String = "com.wetransfer.networking.\(appBundleName)"
let configuration = URLSessionConfiguration.background(withIdentifier: sessionIdentifier)
```

## Shared-container identifier
Để cho extension và host app có thể share session với nhau, ta cần phải setup shared-container identifier  

```swift
let configuration = URLSessionConfiguration.background(withIdentifier: "swiftlee.background.url.session")
configuration.sharedContainerIdentifier = "group.swiftlee.apps"
```

## Chỉ upload từ 1 file
Chúng ta nên save file local trước và sau đó upload file từ location đó.

## Cẩn thận khi dùng isDiscretionary
Khi set bằng true, system sẽ control khi nào nên transfer data. Ví dụ, system có thể delay việc transfer cho đến khi device được cắm vào nguồn điện hoặc khi được connect với wifi.

