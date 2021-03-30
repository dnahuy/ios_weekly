[Original Link](https://www.swiftbysundell.com/tips/property-wrapper-default-values/)

# Automatic handling of property wrapper default values
## Introduction
This post talks about how to custom init of default value in Property Wrapper

## Property Wrapper
```swift
@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}
```
And default value of property will also be wrapped

```swift
struct Document {
    @Capitalized var name = "Untitled document"
}
```
In above example, _"Untitle document"_ will be wrapped

## Property Wrapper with Additional Initializer Parameters
```swift
@propertyWrapper struct CommandLineOverridable {
    let wrappedValue: Bool
    var flagName: String

    private let defaults = UserDefaults.standard

    init(wrappedValue defaultValue: Bool, flagName: String) {
        self.flagName = flagName

        #if DEBUG
        // First, we check if a command line argument matching
        // our flagName even exists, before retrieving a Bool
        // value for it, since otherwise we'd get 'false' back
        // for flags that weren't passed at all:
        if defaults.object(forKey: flagName) != nil {
            wrappedValue = defaults.bool(forKey: flagName)
            return
        }
        #endif

        wrappedValue = defaultValue
    }
}
```
This Property Wrapper received additonal param __flagName__

```swift
struct AppConfiguration {
    @CommandLineOverridable(flagName: "sync")
    static var enableSync = true
    @CommandLineOverridable(flagName: "rememberLogin")
    static var rememberLogin = false
}
```
