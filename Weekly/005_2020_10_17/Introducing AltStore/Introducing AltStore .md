[Original Link](http://rileytestut.com/blog/2019/09/25/introducing-altstore/)

# Introducing AltStore
## Introduction
Tác giả giới thiệu 1 cách work around để có thể cài các app __không thông qua AppStore__, __không cần enterprise cert__ và cũng __không cần jailbroken__.
Tuy không cho publish app tuỳ tiện nhưng Apple cho phép developer deploy app lên chính device của mình kể cả free account (điều này cũng khá dễ hiểu).  
__AltStore__ là 1 app được cài trên device và nó giúp mình browsing cũng như donwload và cài đặt các ipa từ 1 “store” dành riêng cho các App không thể lên được Apple AppStore.
AltStore yêu cầu mình phải __cung cấp AppleID và password__. Sau đó nó sẽ resign lại app bằng AppleID của mình, việc này được thực hiện ngay trên phone của bạn. Nếu lo sợ vấn đề bảo mật mình có thể tạo ra 1 __throw away account__.

## AltServer
Không giống như app được distribute bởi Paid Account, các app distrubute bởi Free Account không thể over-the-air. Không có cách nào để thực sự cài app trực tiếp từ iOS device.
Tuy nhiên hoá ra giới hạn này có thể bypass bằng cách cài app thông qua 1 cơ thế tương tự cách __iTunes Wifi sync__ đã làm. AltServer sẽ giúp chúng ta làm như thế. 
AltStore sẽ gửi resigned app đến AltServer thông qua Wifi, sau đó dùng cùng cơ chế giống như Itunes Wifi sync để cài app ngược lại device.
Dĩ nhiên, mình không thể cài AltStore từ AppStore nên ban đầu AltServer cũng sẽ giúp cài AltStore lên device.

## Refeshing Apps
Tất cả các Apps được sign bằng free Account chỉ valid 7 ngày. Do đó, AltStore sẽ định kỳ refresh tất cả các app đã được cài (có thể chạy background hoặc manual refresh).
Khi có thể connect được với AltServer thì AltStore sẽ gửi các resigned app này đến AltServer sau đó AltServer sẽ lại cài ngược các resigned app này trở lại device.

## Cài đặt nhiều hơn 3 apps
Apple giới hạn chỉ có tối đa 3 app được cài theo cách này, thậm chí là các Apple ID khác nhau.
Hoá ra, iOS không thực sự check sự hiện diện của các app để coi mình có vượt quá số lượng hay chưa, thay vì thế thực ra nó __check các provisioning profiles__.
Cơ chế iTunes Wifi Sync dùng để cài app cũng có thể remove provisiong profiles. Trước khi cài app, remove tất cả các provisioning profiles, sau đó reinstall tất cả các profiles.