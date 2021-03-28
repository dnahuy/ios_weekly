[Original Link](https://peterfriese.dev/ultimate-guide-to-swiftui2-application-lifecycle/)

# The Ultimate Guide to the SwiftUI 2 Application Life Cycle
## Introduction
Giới thiệu về App Lifeycle mới được dùng trong SwiftUI 2

## Entry Point
```swift
import SwiftUI

@main
struct SwiftUIAppLifeCycleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
```

```swift
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension App {

    /// Initializes and runs the app.
    ///
    /// If you precede your ``SwiftUI/App`` conformer's declaration with the
    /// [@main](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID626)
    /// attribute, the system calls the conformer's `main()` method to launch
    /// the app. SwiftUI provides a
    /// default implementation of the method that manages the launch process in
    /// a platform-appropriate way.
    public static func main()
}
```

## application(_:didFinishLaunchingWithOptions:) 
```swift
@main
struct ColorsApp: App {
  init() {
    print("Colors application is starting up. App initialiser.")
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
}
```

## applicationDidBecomeActive,  applicationWillResignActive, applicationDidEnterBackground
```swift
@main
struct SwiftUIAppLifeCycleApp: App {
  @Environment(\.scenePhase) var scenePhase
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .onChange(of: scenePhase) { newScenePhase in
      switch newScenePhase {
      case .active:
        print("App is active")
      case .inactive:
        print("App is inactive")
      case .background:
        print("App is in background")
      @unknown default:
        print("Oh - interesting: I received an unexpected new value.")
      }
    }
  }
}
```

## Handling deep links
```swift
@main
struct SwiftUIAppLifeCycleApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onOpenURL { url in
          print("Received URL: \(url)")
        }
    }
  }
}
```

## Using Old AppDelegate
```swift
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    print("Colors application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    return true
  }
}

@main
struct ColorsApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
```