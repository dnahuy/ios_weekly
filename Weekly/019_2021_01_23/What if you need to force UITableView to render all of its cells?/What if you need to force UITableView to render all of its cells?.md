[Original Link](https://medium.com/plus-minus-one/what-if-you-need-to-force-uitableview-to-render-all-of-its-cells-84096e1fa5fd)

# What if you need to force UITableView to render all of its cells?
## Introduction
Bài viết hướng dẫn cách có thể render toàn bộ cell của TableView chứ không chỉ là các visible cells.

## ScrollView
TableView sẽ được add vào trong 1 ScrollView và sẽ được disable scrollable để tránh xung đột với scroll của ScrollView

```swift
scrollView.addSubview(tableView)
tableView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
updateContentHeight()
```

## updateContentHeight
Sau đó, ta cần tính được content height của TableView và sẽ update lại contentSize của ScrollView

```swift
CATransaction.begin()
tableView.reloadData()
CATransaction.setCompletionBlock { [weak self] in
    guard let self = self else { return }
    let updatedContentHeight = self.tableView.contentSize.height
    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: updatedContentHeight)
    self.tableView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: updatedContentHeight)
}
CATransaction.commit()
```

## User visible cells
Nếu ta cần get được indexPaths của các visible cells (mặc dù toàn bộ cells đã được render), ta có thể dựa vào scrollViewDidScroll của ScrollView

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if self.scrollView == scrollView {
       let offset = scrollView.contentOffset.y
       let scrollViewHeight = scrollView.frame.height
       let shownRect = CGRect(x: 0, y: offset, width: scrollView.frame.width, height: scrollViewHeight)
       let currentlyShownIndexes = tableView.indexPathsForRows(in: shownRect) ?? []
        print(currentlyShownIndexes)
    }
}
```

Ta sẽ tính được content rect và từ đó tính ra được những indexPath có trong đó.