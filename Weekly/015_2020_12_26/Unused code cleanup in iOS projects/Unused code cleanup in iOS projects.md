[Original Link](https://medium.com/@mshcheglov/unused-code-cleanup-in-ios-projects-9789e5d247ca)

# Unused code cleanup in iOS projects
## Introduction
Bài viết giới thiệu về 1 vài tools dùng để clean bớt unused code

## XCode và AppCode
XCode và AppCode có default tool để clean up. Tuy nhiên, cả 2 đều không cung cấp nhiều options để clean up Swift code.

## Swift-script
Là 1 open-source script viết bằng Ruby. Tuy nhiên, kết quả chứa nhiều false-positive nên đòi hỏi ta phải verify lại trước khi clean.

## Periphery
Periphery là 1 open-source tool viết bằng Swift dùng để tìm các unused declaration. Tác giả suggest chúng ta nên integrate Periphery vào trong CI pipeline hoặc chạy manually mỗi 3 - 6 tháng.
