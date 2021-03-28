[Original Link](https://swiftsenpai.com/development/collectionview-expandable-list-part2/)

# Building an Expandable List Using UICollectionView: Part 2
## Introduction
Bài blog này tác giả chia sẻ cách sử dụng UICollectionView mới. Cụ thể là diffadable datasource (__UICollectionViewDiffableDataSource__) và snapshot data (__NSDiffableDataSourceSnapshot__).
Nói chung về cơ chế tổng quan là ta không cần phải tách rời 2 quá trình __numberOfCells__ và  __cellAtIndexPath__ nữa. Việc duy nhất ta cần là cung cấp data thông qua  __Snapshot__ và iOS sẽ tự động dùng __thuật toán diffing__ thích hợp và sẽ có thao tác update thích hợp cho ta thay vì ta phải reload toàn bộ hoặc phải manual reload at indexPaths.

