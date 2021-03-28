[Original Link](https://medium.com/axel-springer-tech/the-common-reuse-principle-on-ios-f4b7b1b945a3)

# The Common Reuse Principle on iOS
## Introduction
Bài viết phân tích về nguyên lý CRP (Common Resuse Principle) trên iOS
	___Common Reuse Principle (CRP): Don’t force users of a component to depend on things they don’t need.___
Các class và module có khuynh hướng reuse chung với nhau thì nên cùng thuộc về 1 component.
Nhưng nếu chúng không thường được reuse chung với nhau?

## Tại sao các class/module lại không được reuse chung với nhau?
Khi chúng ta dùng 1 component khác, chúng ta có 1 sự dependency lên toàn bộ component, đối với tất cả các class. Mặc dù chúng ta có thể chỉ cần sử dụng duy nhất 1 class trong đó, nhưng chúng ta vẫn phải chịu inconvenince của big dependency. 

Mỗi lần component thay đổi chúng ta phải thay đổi tương ứng. Hoặc chúng ta có thể tạo ra 1 clean interface để cho phía chúng ta không cần phải thay đổi gì nhưng chắc chắn là toàn bộ component vẫn phải được compile lại

## Ví dụ
Trong bài blog, tác giả có nêu 1 ví dụ mà mình gặp phải. 
```swift
let htmlData = NSString(string: details).data(using: String.Encoding.unicode.rawValue)

let options = [
       NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]

let attributedString = try? NSMutableAttributedString(
     data: htmlData ?? Data(),
     options: options,
     documentAttributes: nil)
```
Đoạn code trên convert HTML text thành NSAttributedString, nó work nhưng rất chậm. Tác giả mới chuyển sang sử dụng DTCoreText, thực hiện nhanh hơn 18 lần. Tuy nhiên DTCoreText có sử dụng DTFoundation, là 1 tập hợp rất nhiều các utility method và category extensions. Vì thế DTFoundation bao gồm rất nhiều class mà hoàn toàn không liên quan tới use case hiện tại.

## Solution
CRP nói rằng khi chúng ta depend vào 1 component, chúng ta nên depend vào mọi class trong component đó.
Đối với ví dụ trên tác giả lên kế hoạch rút trích ra các class giải quyết đúng cho use case đó thành 1 component của riêng họ.

## ISP (Interface Segregation Principle)
Client không nên bị ép buộc phải depend vào những interface mà chúng không dùng tới.

## Đừng phụ thuộc vào những thứ mà bạn không dùng
Dĩ nhiên là chúng ta sẽ không đi phát minh lại cái bánh xe. Nếu có 1 open source solution đã được chứng minh và được hỗ trợ bởi 1 cộng đồng lớn, chúng ta có thể xem xét dùng nó thoải mái.
Tuy nhiên, trước khi thêm dependency 1 cách mù quáng vào codebase, chúng ta nên dừng lại và phân tích component đó để chắc chắn chúng ta không tạo nên dependency vào những thứ chúng ta không cần.

