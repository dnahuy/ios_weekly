[Origin](https://medium.com/swift2go/embedding-python-interpreter-inside-a-macos-app-and-publish-to-app-store-successfully-309be9fb96a5)

[Usage Guide](https://github.com/beeware/Python-Apple-support/blob/main/USAGE.md)

[briefcase](https://github.com/beeware/briefcase)

[Released framework for Python version](https://github.com/beeware/Python-Apple-support/releases)

[Python Embedded C API](https://docs.python.org/3/extending/embedding.html)
 
[PythonKit](https://github.com/pvieito/PythonKit)

# Embedding a Python interpreter inside a MacOS / iOS app, and publishing to the App Store successfully
## Introduction
A quick and simple guide on how-to embed a Python interpreter into your app

## Step-by-step to embed Python interpreter in a MacOS app

* Download Released Framwork
* Add `python-stdlib` and `Python.xcframework` and setup XCode project
* Add `Run Script`
```
set -e
echo "Signing as $EXPANDED_CODE_SIGN_IDENTITY_NAME ($EXPANDED_CODE_SIGN_IDENTITY)"
find "$CODESIGNING_FOLDER_PATH/Contents/Resources/python-stdlib/lib-dynload" -name "*.so" -exec /usr/bin/codesign --force --sign "$EXPANDED_CODE_SIGN_IDENTITY" -o runtime --timestamp=none --preserve-metadata=identifier,entitlements,flags --generate-entitlement-der {} \;
```
* Add PythonKit by using the Swift Package manager
* Create a file called module.modulemap
```swift
module Python {
    umbrella header "Python.h"
    export *
    link "Python"
}
```
* In Swift code, initialize the Python runtime
```swift
import Python

guard let stdLibPath = Bundle.main.path(forResource: "python-stdlib", ofType: nil) else { return }
guard let libDynloadPath = Bundle.main.path(forResource: "python-stdlib/lib-dynload", ofType: nil) else { return }
setenv("PYTHONHOME", stdLibPath, 1)
setenv("PYTHONPATH", "\(stdLibPath):\(libDynloadPath)", 1)
Py_Initialize()
// we now have a Python interpreter ready to be used
```
* Invoke Python code in app
```swift
import PythonKit

let sys = Python.import("sys")
print("Python Version: \(sys.version_info.major).\(sys.version_info.minor)")
print("Python Encoding: \(sys.getdefaultencoding().upper())")
print("Python Path: \(sys.path)")

_ = Python.import("math") // verifies `lib-dynload` is found and signed successfully
```

* To integrate 3rd party python code and dependencies
    - Need to make sure PYTHONPATH contains their paths
    - Once this has been done, we can run Python.import("<lib name>"). to import that module from inside swift.

## PythonKit
Some Python code like this:
```python
import sys

print(f"Python {sys.version_info.major}.{sys.version_info.minor}")
print(f"Python Version: {sys.version}")
print(f"Python Encoding: {sys.getdefaultencoding().upper()}")
```
\
\
Can be implemented in Swift
```swift
import PythonKit

let sys = Python.import("sys")

print("Python \(sys.version_info.major).\(sys.version_info.minor)")
print("Python Version: \(sys.version)")
print("Python Encoding: \(sys.getdefaultencoding().upper())")
```
