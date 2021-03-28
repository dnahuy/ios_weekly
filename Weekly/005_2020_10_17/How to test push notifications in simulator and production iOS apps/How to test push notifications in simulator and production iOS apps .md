[Original Link](https://onmyway133.com/blog/how-to-test-push-notifications-in-simulator-and-production-ios-apps/)

# How to test push notifications in simulator and production iOS apps 
## Introduction
Bài viết này tác giả chủ yếu đề cập đến những thay đổi ở phía APNs provider API. 
Những thay đổi này thực tế không ảnh hưởng gì đến iOS client app nhưng vẫn sẽ tốt nếu chúng ta có thể hiểu cơ chế hoạt động từ phía server.

## Binary provider API

![](resources/noti_1.png)

__gateway.push.apple.com, port 2195__
__gateway.sandbox.push.apple.com, port 2195__

TLS/SSL channel

## HTTP/2 provider API
* JSON payload muốn gửi
* Device token của user
* Request-header field xác định cách deliver notification
* Nếu là token-based authen, phải cung cấp authentication token hiện tại.

Dùng HTTP/2 và TLS 1.2 để thiết lập kết nối.
__api.sandbox.push.apple.com:443__
__api.push.apple.com:443__

## Certicate authentication
Gen 1 APNs cert từ Developer account.

## Token authentication

![](resources/noti_2.png)

Get được:
1. __Key ID__
2. __Authentication token signing key__

HTTP request header
```
authorization = bearer eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0I
		 jogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6
		 Lxw7LZtEQcH6JENhJTMArwLf3sXwi
```
