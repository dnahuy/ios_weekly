[Original Link](https://www.andyibanez.com/posts/nil-null-mess-objective-c-and-swift/)

# nil-null-mess in Objective-C and Swift
## Introduction
Bài viết nói về nil/null và những tình huống thực tế cần phải lưu ý khi dùng chúng trong Objective-C và Swift.

## nil
Trong Objective-C, ta có thể send message đến giá trị nil mà không gây ra crash. Trong Swift, ta cũng có thể send message đến nil thông qua optional chain và cũng sẽ không crash

## Array
Ví dụ về việc dùng nil trong Objective-C Array

```objc
NSArray<NSString *> *array = [NSArray arrayWithObjects:@"Alice", nil, @"Eileen", @"Sepia Alice", nil];
NSLog(@"%d", (unsigned)array.count);
```

Kết quả print ra sẽ là 1 do __nil__ là terminator trong Obj-C Array

## NSNull
Nếu ta dùng NSNull thay vì nil

```objc
NSArray<NSString *> *array = [NSArray arrayWithObjects:@"Alice", [NSNull null], @"Eileen", @"Sepia Alice", nil];
```

Lúc này, count sẽ trả về đúng là 4, __NSNull__ được xem như là 1 object hoàn chỉnh trong Obj-C (vẫn kế thừa từ NSObject).
Do đó, nếu ta print array trên ta sẽ được kết quả như sau:
```
Alice
<null>
Eileen
Sepia Alice
```

## nil và Swift
```swift
let dolls: [String?] = ["Alice", nil, "Eileen", "Sepia Alice"]

for doll in dolls {
  print(doll)
}
```

Kết quả sẽ là:
```
Optional("Alice")
nil
Optional("Eileen")
Optional("Sepia Alice")
```

## Objective-C dictionary
Ví dụ, ta cần parse JSON sau:

```json
{
  "Pullip": [
    "Classical Alice",
    "Eileen",
    "Alice Sepia"
  ],
  "Myou": [
    "Delia",
    "Matcha"
  ],
  "HarmoniaBloom": null
}
```

```objc
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

NSLog(@"%@", dictionary[@"Nendoroid"]);
NSLog(@"%@", dictionary[@"HarmoniaBloom"]);
```
Kết quả in ra sẽ là:
```
(null)
<null>
```

Trong ví dụ trên, chúng ta có thể thấy rằng dictionary không có chứa key Nendoroid, và value sẽ là nil, nhưng value của key HarmoniaBloom sẽ là NSNull.
Điều này rất quan trọng cần phải lưu ý vì không như nil, nếu ta send message đến NSNull thì sẽ bị crash
Ví dụ:

```objc
for(NSString *doll in dictionary[@"HarmoniaBloom"]) {
  NSLog(@"%@", doll);
}
```

Đoạn code này sẽ làm crash app.

## Swift dictionary
Sử dụng data JSON như trên, ta sẽ parse nó bằng Swift như sau:

```swift
let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: [String]]
```

Lần này, app sẽ crash khi lệnh trên được thực thi:
```sh
Could not cast value of type 'NSNull' (0x7fff86d72b38) to 'NSArray' (0x7fff86d72430)
```

Do đó, ta nên parse nó về kiểu optional array (__[String]?__)
```swift
let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: [String]?]

print(dictionary["Nendoroid"])
print(dictionary["HarmoniaBloom"])
```
Kết quả in ra sẽ là:
```swift
nil
Optional(nil)
```