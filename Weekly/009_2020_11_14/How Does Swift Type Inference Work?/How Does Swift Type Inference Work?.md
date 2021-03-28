[Original Link](https://medium.com/swlh/how-does-swift-type-inference-work-c287fae34da0)

# How Does Swift Type Inference Work?
## Introduction
Bài viết giới thiệu về Swift type inference và 1 vài ví dụ minh hoạ

## Explicitly
```swift
let stringLabel: String = "I am a string!"
var intValue: Int = 4
```
## Implicitly (type inference)
```swift
let stringLabel = "I am a string!"
var intValue = 4
```
## Limits
```swift
func testFunc() {
  let myValue
  let someCondition = true
  if someCondition {
    myValue = 2
  } else {
    myValue = 4
  }
}
```
Mặc dù myValue là constant 2, 4 là các giá trị Int nhưng đoạn code trên sẽ __compile erorr.__ 
Nói chung, trong Swift chúng ta sẽ chỉ có 2 option: hoặc là gán 1 giá trị at the beginning để Swift có thể type inference hoặc là cho Swift biết type thực sự là gì.