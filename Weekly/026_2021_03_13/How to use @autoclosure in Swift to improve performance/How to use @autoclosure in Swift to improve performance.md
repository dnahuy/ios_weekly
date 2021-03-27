[Original Link](https://www.avanderlee.com/swift/autoclosure/)

# How to use @autoclosure in Swift to improve performance

## Introduction
This post talks about using autoclosure to improve performance.

## Example
```swift
let isDebuggingEnabled: Bool = false
 
func debugLog(_ message: String) {
     /// You could replace this in projects with #if DEBUG
     if isDebuggingEnabled {
         print("[DEBUG] \(message)")
     }
}

let person = Person(name: "Bernie")
debugLog(person.description)
```
Even we disabled _isDebugging_, the _Person_ structure is still asked for its description (it isn’t just be printed).

## Improving by @autoclosure
```swift
func debugLog(_ message: @autoclosure () -> String) {
     /// You could replace this in projects with #if DEBUG
     if isDebuggingEnabled {
         print("[DEBUG] \(message())")
     }
}

debugLog(person.description)
```
_Person’s description_ won’t be asked if _isDebugging_ is disabled.