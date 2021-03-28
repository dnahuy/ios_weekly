[Original Link](https://medium.com/revolut/the-fundamentals-of-ios-at-revolut-57422078c903)

# The Fundamentals of iOS at Revolut
## Introduction
Chia sẻ về iOS Development tại Revolut - 1 công ty Fintech Anh

## Release train
Họ có 3 app iOS: Revolut, Revolut Junior và Revolut Business được update trên AppStore weekly.
Họ áp dụng __CI/CD__ để produce new functionality cho user nhanh nhất.

#### Thứ 4
* __Sign-off:__ Approve the changes and enable toggles
* __Toggle check:__ Release manager checks only toggles are on
* __Code freeze:__ merge từ dev vào nhánh release và kể từ lúc này, chỉ critical fixes mới có thể add vào release candidate.

#### Thứ 5
* Internal/External beta version

#### Thứ 3 tiếp theo
* Release

## Architecture
* __Clean Architecture + MVVM__
* Sử dụng __Flow Coordinator__
* Các app __không monolithic__ -> có khoảng __60 modules__.
* __Shared modules__ như là core module, UI Components module, chat module
* __Feature modules__ như là Trading, Payments, Credit.
* Sủ dụng __Monorepo__
* Sử dụng __Modular Architect__:
    * Faster build times
    * Faster development
	* Isolated environment
	* Tests running

## Tech stack
#### Swift + iOS SDKs
#### Không dùng RxSwift mà tự implement của mình.
#### Các tool và tech khác đang dùng
* XCode và Git client (ví dụ Sourcetree)
* Figma
* CoreData
* Danger để check PR 
* SwiftLint check code style
* fastlane và TeamCity để hỗ trợ CI

(Danger runs after your CI, automating your team's conventions surrounding code review: Enforce CHANGELOGs, Enforce links to Trello/JIRA in PR/MR bodies).
Mỗi tháng, iOS team __build app 15000 lần__ -> dùng __Bazel__ của Google.

## Cross-functional teams
Mỗi team đều có iOS, Android, Web, Backend, PO, Designer và Data Analyst

## Shared Principles
Các nguyên lý chung mà các teams phải tuân theo.
1. __Security__ của customer data.
2. __Automated testing:__ 
	•	automated UI tests
	•	unit test
	•	screenshot/snapshot tests

## Design consistency
Phân tích UI components để có thể ___tái sử dụng___ tối đa trong các app và lưu tất cả trong 1 ___Design System___. Họ tạo ra hệ thống này với ý tưởng chính là atomic design.
