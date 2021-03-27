[Original Link](https://michael-kiley.medium.com/why-your-lazy-vars-arent-creating-strong-reference-cycles-in-ios-d512ff2c9403)

# Why Your Lazy Vars Aren’t Creating Strong Reference Cycles in iOS

## Giới thiệu
Bài viết giải thích tại sao việc sử dụng closure đối với lazy var lại không tạo ra strong reference (và vì thế cũng không cần khai báo __weak__ hay __unowned self__)

## Background
Như ta đã biết việc sử dụng self trong closure có thể gây ra reference cycle nếu closure đó cũng được strong reference bởi self (nên thường trong closure sẽ phải dùng weak hay unowned self).

## Lazy property closure
```swift
class Person {
    let firstName : String!
    let lastName : String!
    
    lazy var fullName : String = {
        return firstName + " " + lastName
    }()
    
    init(firstName : String, lastName : String) {
        
        self.firstName = firstName
        self.lastName = lastName
        
    }
    
    deinit {
        print("Person deinit called")
    }
}
```

Như ta thấy ở ví dụ trên, __fullName__ là 1 lazy property từ Closure có reference đến 2 stored property là firstName và fullName. Closure này không cần capture weak hay unowned self và như ta thấy là thậm chí nó không cần phải capture self.
2 property firstName và lastName được dùng 1 cách implicitly trong closure (không cần self.firstName, self.lastName).
Tại sao lazy property closure có thể làm được như vậy?

## @noescape
Joe Groff, Senior Swift Compiler Engineer tại Apple đã trả lời: “When you immediately apply a closure, it’s automatically noescape”.
__@noescape__ là 1 keyword  xác định rằng closure sẽ không được retain và cũng sẽ không được gọi bên ngoài lifetime của context của nó.
Lazy property closure sẽ được apply immediately khi access đến property, do đó nó sẽ là @noescape. Ta có thể reference self implicitly và vì closure không được retain nên ta cũng không cần phải dùng weak hay unowned.