[Original Link](https://www.avanderlee.com/xcode/xcode-mark-line-comment/)

# Xcode Mark Line to improve readability using // Mark: comments
## Introduction
Bài viết hướng dẫn cách sử dụng MARK để làm tăng tính readability

## Adding // MARK header
```swift
// MARK: UICollectionViewDelegate
```
## Adding // MARK header với line separator
```swift
// MARK:- UICollectionView methods
```
## Chỉ add line separtor
```swift
// MARK:- 
```
## Adding // FIXME: Comment
```swift
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // FIXME: Use the view model for this number.
    return 10
}
```
## Adding // TODO: Comment
```swift
func numberOfSections(in collectionView: UICollectionView) -> Int {
    // TODO: Use the view model for this number.
    #warning("Use the view model for this number.")
    return 1
}
```