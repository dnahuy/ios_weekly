[Original Link](https://www.andyibanez.com/posts/benchmarking-app-metrickit/)

# Benchmarking Your App with MetricKit
## Introduction
Cần đo performance của app ở thế giới thực. Not only performance and battery usage but also exeptions and crash reports.

## Implementing
```swift
// In AppDelegate
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    MXMetricManager.shared.add(self)
    return true
}

// ...
// Creating an extension to conform to MXMetricManagerSubscriber
extension AppDelegate: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        // Handle payloads here
    }
}
```

## Mannually logging critical sections
```swift
let filterLog = MXMetricManager.makeLogHandle(category: "Picture Filter")

func applyFilter(nanmed name: String) {
    mxSignpost(.begin, log: filterLog, name: "\(name) filter")
	// Long running operation of applying a filter here
	// ..
	// Don't forget to call end to end the data collection. This can go inside a completion handler as well.
    mxSignpost(.end, log: filterLog, name: "\(name) filter")
}
```

## MetricKit Diagnostics
Crash reporting. Cũng cho phép get stack trace của call site. Not only performance and battery usage but also exeptions and crash reports.
```swift
func didReceive(_ payloads: [MXDiagnosticPayload]) {
     // Handle payloads here
}
```

## Is end of in-process crash reporting?
Có lẽ không vì MetricKit vẫn đang còn 1 vài limitations
* User phải opted-in và share diagnostic và usage data. Không sure user sẽ làm thế.
* Chỉ có thể request data 24hour/day -> unnotice crash
* Required iOS 14
