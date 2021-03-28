[Original Link](https://www.swiftbysundell.com/articles/validating-email-addresses/)

# Validating email addresses using RawRepresentable and NSDataDetector
## Introduction
Bài viết giới thiệu về cách để validate 1 string xem có phải là email format hay không?

## NSPredicate và Regular Expression
Để validate 1 string có phải là email hay không cách thông thường nhất mà ta thường dùng là dùng NSPredicate kết hợp với RE.
Tuy nhiên, nếu chúng ta lưu email dưới dạng raw string thì sẽ gặp 1 nhược điểm lớn là không thể bảo đảm chắc là nó có phải là email hay không.

```swift
struct User: Codable {
    var name: String
    var emailAddress: String
}
```

Như ví dụ trên, ta không thể bảo đảm được là emailAddress của User là email format nếu ta không kiểm tra nó trước khi sử dụng.

## EmailAddress và RawRepresentable
Ta có thể định nghĩa 1 struct EmailAddress để mô tả email và dùng RawPresentable để init và lưu rawValue

```swift
struct EmailAddress: RawRepresentable, Codable {
    let rawValue: String

    init?(rawValue: String) {
        // Validate the passed value and either assign it to our
        // rawValue property, or return nil.
        ...
        
        // Verify that the found link points to an email address,
        // and that its range covers the whole input string:
        guard match.url?.scheme == "mailto", match.range == range else {
            return nil
        }

        self.rawValue = rawValue
    }
}
```

struct này nhận vào 1 rawValue, tiến hành validate nó và sẽ return nil về nếu như rawValue không phải là email format.
