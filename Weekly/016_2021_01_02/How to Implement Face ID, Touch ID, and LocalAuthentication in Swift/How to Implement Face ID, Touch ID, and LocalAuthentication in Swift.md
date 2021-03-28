[Original Link](https://betterprogramming.pub/face-id-touch-id-and-localauthentication-df0e20f212b3)

# How to Implement Face ID, Touch ID, and LocalAuthentication in Swift
## Introduction
Bài viết giới thiệu về cách sử dụng Biometrics Authentication (FaceID hoặc TouchID)

## LAContext
```swift
func canEvaluatePolicy(_ : LAPolicy, error: NSErrorPointer) -> Bool
```
Check xem có thể thực hiện được 1 policy nào đó hay không?

Ví dụ policy:
```swift
deviceOwnerAuthenticationWithBiometrics
```

Policy này xác định rằng chúng ta sẽ tiến hành authen bằng Biometrics (FaceID hoặc TouchID).

```swift
func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
```

Tiến hành evaluate policy đã chọn.

## LAPolicy

* __deviceOwnerAuthenticationWithBiometrics:__ Authen bằng FaceID hoặc TouchID
* __deviceOwnerAuthenticationWithWatch:__ Authen bằng Watch
* __deviceOwnerAuthenticationWithBiometricsOrWatch:__ Authen bằng FaceID/TouchID hoặc Watch
* __deviceOwnerAuthentication:__ Authen bằng FaceID/TouchID hoặc Watch hoặc device passcode

## Domain State
Ngoài ra, ta có thể check xem Biometrics có bị thay đổi hay không, ví dụ new fingerprint mới được add vào hoặc fingerprint cũ bị delete đi.
Ta có thể detect bằng cách check xem domain có bị thay đổi hay không.

```swift
let context = LAContext()
context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil)

if let domainState = context.evaluatedPolicyDomainState
   where domainState == oldDomainState  {
    // Enrollment state the same
    
} else {
    // Enrollment state changed
}
```