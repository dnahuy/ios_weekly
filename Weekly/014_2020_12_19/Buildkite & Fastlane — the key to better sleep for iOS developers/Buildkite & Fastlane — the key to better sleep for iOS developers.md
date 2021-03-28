[Original Link](https://medium.com/engineering-at-tink/buildkite-fastlane-the-key-to-better-sleep-for-ios-developers-2d01f429f95c)

# Buildkite & Fastlane — the key to better sleep for iOS developers
## Introduction
Bài viết giới thiệu về cách sử dụng __Buildkite__ (CI platform) và __Fastlane__ tại công ty của tác giả

## Buildkite
Các bước để setup tác giả không đi sâu vào detail, chủ yếu là sẽ có 3 pipelines
* __Check PR__
* __Deploy Tink iOS đến Hockeyapp__
* __Clean up build machine__

## Check PR
Build Pull Request để đảm bảo rằng builds trong master không bị break. Ngoài ra, ta có thể include thêm vào unit test hoặc UI testing trong pipeline này.

## Deploy Tink iOS đển HockeyApp
App sẽ được release lên AppStore 2 đến 3 lần 1 tháng. Các features, fixed bugs được add vào hàng ngày. Mỗi lần 1 Pull Request được merge, 1 new release sẽ made available trên HockeyApp.
Fellow Tinkers, design team và developers đều sẽ sử dụng HockeyApp releases daily để thử tính năng mới và verify rằng mọi thứ vẫn work cho đến khi nó đến được end users.

## Clean up Build Machine
Pipeline này chủ yếu sẽ lo việc update dependencies và remove các generated archives chiếm khoảng 400GB mỗi 6 tuần trên 1 máy. Pipeline này sẽ được chạy tự động 1 lần 1 tuần.

## Fastlane 
Phần tiếp theo trong solution là fastlane, đây là 1 automation tool rất quen thuộc đối với iOS projects. Nó có thể được chạy local hoặc trên CI/CD environment.
2 Buildkite pipeline có dùng fastlane là __Check PR__ và __Deploy Tink iOS__
 
## Check PR
Thường chúng ta sẽ run test để check xem chúng có pass hay không.  Ngoài ra,  có 1 lane được gọi là __prcheck_or_build__,  nó sẽ check last commit message, và nếu có chứa [hockey],  nó sẽ tạo ra 1 HockeyApp build từ PR bên cạnh việc run các test.

## Deploy Tink iOS
Được gọi khi 1 PR được merge vào. Chúng ta có thể set build number cho bản build manually (option truyền vào) hoặc tự động (đếm số lượng commit).