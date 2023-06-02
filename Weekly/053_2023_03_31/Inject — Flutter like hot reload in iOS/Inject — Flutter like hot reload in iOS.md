[Origin](https://github.com/krzysztofzablocki/Inject)

# Inject — Flutter like hot reload in iOS
## Introduction
* With [Inject](https://github.com/krzysztofzablocki/Inject) , we're able to hot reload our SwiftUI and UiKit app.

https://user-images.githubusercontent.com/26660989/161756368-b150bc25-b66f-4822-86ee-2e4aed713932.mp4

## Does it add manual overhead to my workflows?
* Don’t need to add conditional compilation or remove Inject code from  applications for production
* It's already designed to behave as no-op inlined code that will get stripped by LLVM in non-debug builds

## Initial project setup

## Workflow integration
#### SwiftUI

#### UIKit / AppKit
* _Inject.ViewControllerHost_
* _Inject.ViewHost_

```swift
// WRONG
let viewController = YourViewController()
rootViewController.pushViewController(Inject.ViewControllerHost(viewController), animated: true)

// CORRECT
let viewController = Inject.ViewControllerHost(YourViewController())
rootViewController.pushViewController(viewController, animated: true)


// Remember you don't need to remove this code when you are done, it's NO-OP in production builds.
```


