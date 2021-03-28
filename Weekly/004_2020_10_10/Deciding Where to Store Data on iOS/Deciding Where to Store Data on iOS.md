[Original Link](https://medium.com/better-programming/deciding-where-to-store-data-on-ios-3f71e5d850c8)

# Deciding Where to Store Data on iOS
## Introduction
Có 4 cách để lưu data trên iOS:
1. __UserDefaults__
2. __Files__
3. __Keychain__
4. __Databases__

## UserDefaults

Dễ dùng nhất, thường dùng để lưu các user preferences đơn giản hoặc lưu các giá trị đơn giản để improve UX.

#### Những thứ nên lưu
Giới hạn kích thước tối đa 1MB và Apple khuyên là không nên vượt quá 512KB (con số này thực sự Apple không có nêu trong documents). Dung lượng này cũng vẫn là rất nhiều để chỉ lưu data đơn giản như các primitive type.

#### Security
Storage này không được encrypted bất cứ gì cả. Không bao giờ lưu sensitive data ở UserDefaults.

#### Cách dùng
Chúng ta nên tự tạo UserDefaults của mình thay vì dùng cái có sẵn trong app. Giúp dễ thay đổi cái UserDefaults của riêng mình.  Ví dụ trong 1 vài case ta có thể “mạnh tay” xoá sạch UserDefaults được tạo riêng đó. Đọc từ UserDefaults thực sự nhanh vì nó được load vào memory khi app launch.

## Files
Có thể lưu data lớn nhưng sẽ chậm

#### Những thứ nên lưu
Hình, videos, file JSON lớn, các documents mà user tạo ra như text file, PDF.

#### Security
Không secure.

#### Cách dùng
Ghi file xuống thư mục Documents hoặc thư mục Cache.

## Keychain
Lưu ___sensitive data___

#### Những thứ nên lưu
Password, cert, token, v.v…

#### Security
Secure. Tuy nhiên, như mọi thứ ở trên device, keychain vẫn có thể bị crack.

#### Cách dùng
Khó dùng nên best option là dùng các third party như KeychainAccess

## Database

Thích hợp lưu dữ liệu lớn của các data có cấu trúc. Không chỉ thích hợp lưu mà còn rất thích hợp trong việc search và filter.

#### Những thứ nên lưu
Metadata của Documents mà user tạo ra trong App.
Weekly running exercises của user.
To-do list của user.

#### Security
Database thường được lưu ở thư mục Documents. Vẫn không nên dùng để lưu sensitve data.

#### Cách dùng
SQL queries. Lưu ý: database thường không thread-safe
