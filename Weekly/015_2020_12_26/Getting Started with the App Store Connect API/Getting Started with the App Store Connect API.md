[Original Link](https://www.andyibanez.com/posts/getting-started-app-store-connect-api/)

# Getting Started with the App Store Connect API
## Introduction
Bài viết giới thiệu về cách sử dụng AppStore Connect API.

## AppStore Connect API
Dùng RESTful API, authenticate bằng JWT (Jason Web Token) token.

## Features
#### App Management:
* Tạo new version
* Manage phased release
* Submit app for review

#### App Metadata:
* Edit App Metadata

#### Pricing and Availability:
* Quản lý app’s price and availability, price tiers

#### Power and Performance:
* Get data của launch time, hang rates, disk writes, memory use, battery life

#### Provisioning:
	•	Quản lý bundle IDs, certificates, development devices, provisioning profiles

#### Reporting:
	•	Quản lý Sales và Trends
	•	View Payment và Financial reports

#### TestFlight:
	•	Remove hoặc add tester
	•	Manage tester group
	•	Manage builds

#### Users and Roles:

## Request AppStore Connect access
#### Requesting Permission
Cần phải là Account Holder

#### Generate Keys
Tạo ra Key cùng với Permission cho nó, sau đó ta phải download nó về (.p8 format). Lưu ý, chúng ta chỉ có thể download nó về 1 lần vì vậy cẩn thận đừng để mất nó.

#### Generate Access Tokens
Sử dụng Private Key đã download được trước đó, ta tạo ra JWT Token

## Using API
Sau khi có JWT token rồi, ta có thể bắt đầu sử dụng API bằng các HTTP request