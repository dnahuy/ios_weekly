[Original Link](https://useyourloaf.com/blog/tweaking-the-ios-system-fonts/)

# Tweaking The iOS System Fonts

## Introduction
This post talks about iOS system fonts.

## Font Design
From iOS 13, there are two families of system font: ___San Francisco___ and ___New York___. There are four options of font design:
* __default:__ SF Pro
* __monospaced:__ SF Mono
* __rounded:__ SF Pro Rounded
* __serif:__ New York

Example:
```swift
// UIKit - rounded large title font
if let descriptor = UIFontDescriptor
    .preferredFontDescriptor(withTextStyle: .largeTitle)
    .withDesign(.rounded) {
    titleLabel.font = UIFont(descriptor: descriptor, size: 0)
}

// UIKit - New York body font
if let descriptor = UIFontDescriptor
    .preferredFontDescriptor(withTextStyle: .body)
    .withDesign(.serif) {
    bodyText.font = UIFont(descriptor: descriptor, size: 0)
}
```

In this example, ProfilePresenter directly denpends on ProfileViewController. So ProfilePresenter cannot easily replace current view (ProfileViewController) with another view.
Example, a new view for premium users.

_So, we break the current dependency into two weaker dependencies and point them to the new abstraction._
```swift
protocol ProfileViewing: class {
    func showFullName(_ fullName: String)
}

class ProfileViewController: UIViewController, ProfileViewing {
    func showFullName(_ fullName: String) { }
}

class ProfilePresenter {
    private weak var profileView: ProfileViewing?

    init(profileView: ProfileViewing) {
        self.profileView = profileView
    }

    func presentProfile(_ profile: Profile) {
        let fullName = profile.name + " " + profile.surname
        profileView?.showFullName(fullName)
    }
}
```
## Symbolic traits
Besides font family, we can vary many of characteristics of typeface by applying one or symbolic traits to font descriptor.
Example:
```swift
if let descriptor = UIFontDescriptor
    .preferredFontDescriptor(withTextStyle: .body)
    .withSymbolicTraits([.traitItalic, .traitBold]) {
    bodyText.font = UIFont(descriptor: descriptor, size: 0)
}
```