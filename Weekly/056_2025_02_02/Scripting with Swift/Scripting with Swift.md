[Link](https://medium.com/bforbank-tech/scripting-with-swift-d4ee4ebe97a9)

# Scripting with Swift
## Introduction
We can use Swift for script tasks


## Hello World, the Swift way !
#### Swift toolchain
```
swift -version
> swift-driver version: 1.115.1 Apple Swift version 6.0.3 (swiftlang-6.0.3.1.10 clang-1600.0.30.1)
> Target: arm64-apple-macosx14.0
```

#### file Script.swift
```swift
import Foundation

print("hello, world!")
```

#### Run
```
swift Script.swift
```

## Why Swift script can be better alternative to a shell script?
#### Full potential of Foundation Framework or Any other framework or library

```swift
import Foundation
``` 

####  With Swift, we can
* automate templating and code generation directly from apis documentation
    - [Stencil](https://stencil.fuller.li/en/latest/)
* access system process just like shell script
    - [Process](https://developer.apple.com/documentation/foundation/process/)
* benefit from Swift existing advantages ( Rich frameworks, Structured concurrency, Macro, Property wrappers, SPM …)

