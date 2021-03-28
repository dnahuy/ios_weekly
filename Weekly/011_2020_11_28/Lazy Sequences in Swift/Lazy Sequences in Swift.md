[Original Link](https://www.andyibanez.com/posts/lazy-sequences-in-swift/)

# Lazy Sequences in Swift
## Introduction
Bài viết giới thiệu về lazy khi dùng Collection Swift với High Order Function
```swift
struct Character {
  let name: String
}

var characters = ["Elize", "Arietta", "Anise"]

let mappedCharacters = characters.map { Character(name: $0) } // A new collection of 3 elements
let lazyMappedCharacters = characters.lazy.map { Character(name: $0) } // This won't execute any code until you need it.

print(lazyMappedCharacters[2])
```
Như ví dụ trên, chỉ khi câu lệnh print được thực hiện thì lúc này lazy collection (lazyMappedCharacters) mới refer tới original (characters), search index thứ 2 và apply closure.

## Khi nào dùng Lazy Sequences khi nào dùng Standard sequences?
Đầu tiên, lazy sẽ không cache giá trị lại, tức là như ví dụ trên nếu ta liên tục gọi print(lazyMappedCharacters[2]) thì original sẽ liên tục được refer lại và liên tục được apply closure lại.
Gọi __.filter__ và sau đó gọi __.count__ trên lazy sequence sẽ chậm hơn trên non-lazy sequence.
Mặc khác, nếu chúng ta không có nhiều memory hoặc chúng ta không cần kết quả ngay lập tức của .filter hoặc .map, ta có thể dùng lazy.
