[Original Link](https://medium.com/flawless-app-stories/ignorance-of-the-urlrequest-cache-a3584bc2f05f)

# Ignorance of the URLRequest cache
## Introduction
Bài viết giới thiệu về các cache policy của URLRequest (dĩ nhiên là cache ở phía client chứ chúng ta không xét đến cache phía BE).

## Caching Strategies
NSURLRequest có 1 property là cachePolicy, nó là 1 enum gồm
* case useProtocolCachePolicy
* case reloadIgnoringLocalCacheData
* case reloadIgnoringLocalAndRemoteCacheData
* static var reloadIgnoringCacheData: NSURLRequest.CachePolicy
* case returnCacheDataElseLoad
* case returnCacheDataDontLoad
* case reloadRevalidatingCacheData

## useProtocolCachePolicy
Đây là policy default. URLRequest sẽ sử dụng caching logic được định nghĩa bởi protocol (nếu protocol có định nghĩa).

## Caching logic của HTTP/HTTPS
1. Nếu cached response không tồn tại, URL loading system sẽ fetch data từ originating source.
2. Ngược lại, nếu có cached nhưng cached response không yêu cầu phải được revalidated mỗi lần và response cũng chưa cũ (chưa vượt qua expiration date), cached sẽ được trả về.
3. Nếu cached reponse đã cũ hoặc cần revalidate, URL loading system sẽ tạo 1 HEAD request đến originating source để xem resource có changed hay không. Nếu có, fetch data từ source, ngược lại sẽ trả cached về.
