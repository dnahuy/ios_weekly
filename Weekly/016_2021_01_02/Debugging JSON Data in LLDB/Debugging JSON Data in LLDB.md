[Original Link](https://soffes.blog/debugging-json-data-in-lldb)

# Debugging JSON Data in LLDB
## Introduction
Bài viết giới thiệu về snippet nhỏ giúp chúng ta có thể dễ dàng print ra JSON trong khi debug bằng LLDB

```sh
command regex json 's/(.+)/expr let input = %1; print(String(data: try! JSONSerialization.data(withJSONObject: (input is String ? try! JSONSerialization.jsonObject(with: (input as! String).data(using: .utf8)!, options: []) : (input is Data ? (try! JSONSerialization.jsonObject(with: input as! Data, options: [])) : input as! Any)), options: [.prettyPrinted]), encoding: .utf8)!)/'
```

Lúc debug, thay vì dùng po chúng ta có thể viết như sau:

```
(lldb) json data
{
  "given_name": "Sam",
  "family_name": "Soffes"
}
```

Chúng ta có thể add đoạn snippet này vào __~/.lldbinit__ để nó luôn available

