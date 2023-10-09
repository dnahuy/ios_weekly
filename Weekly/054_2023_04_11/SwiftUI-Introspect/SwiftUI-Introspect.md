[Link](https://github.com/siteline/SwiftUI-Introspect)

# SwiftUI-Introspect
## Introduction
SwiftUI Introspect allows you to get the underlying UIKit or AppKit element of a SwiftUI view.
For instance, with SwiftUI Introspect you can access UITableView to modify separators, or UINavigationController to customize the tab bar.

## Example
```swift
List {
    Text("Item")
}
.introspect(.list, on: .iOS(.v13, .v14, .v15)) { tableView in
    tableView.backgroundView = UIView()
    tableView.backgroundColor = .cyan
}
.introspect(.list, on: .iOS(.v16, .v17)) { collectionView in
    collectionView.backgroundView = UIView()
    collectionView.subviews.dropFirst(1).first?.backgroundColor = .cyan
}
```