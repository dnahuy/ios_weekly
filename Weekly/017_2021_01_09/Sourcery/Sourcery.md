[Original Link](https://github.com/krzysztofzablocki/Sourcery)

# Sourcery
## Introduction
Sourcery là 1 command line tool dùng để generate ra Swift code
Ví dụ:

```swift
extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        guard lhs.firstName == rhs.firstName else { return false }
        guard lhs.lastName == rhs.lastName else { return false }
        guard lhs.birthDate == rhs.birthDate else { return false }
        return true
    }
}
```

Để có thể conform Equatable protocol, trước Swift 4.1 chúng ta phải write hàm == bằng tay như thế này. Từ Swift 4.1, chúng ta đã có thể auto synthesized equatable.
Tuy nhiên, nếu muốn chúng ta vẫn có thể dùng Sourcery để auto gen ra hàm equal.

Ví dụ:

```swift
protocol AutoEquatable { }

public struct Person: AutoEquatable {
    public let name: String
    public let age: Int
    public let gender: Gender
    
    public init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}
```

Ta định nghĩa 1 protocol AutoEquatable như 1 annotation để cho Sourcery có thể “nhận biết” và gen code. Sau đó, ta sẽ có đoạn template language để gen code.

```swift
{% for type in types.implementing.AutoEquatable %}
extension {{ type.name }}: Equatable {
    public static func ==(lhs: {{ type.name }}, rhs: {{ type.name }}) -> Bool {
        {% for var in type.variables %}
         guard lhs.{{ var.name }} == rhs.{{ var.name }} else { return false }
         {% endfor %}

         return true
    }
}
{% endfor %}
```

Chạy đoạn template trên bằng Sourcery ta sẽ gen ra được code mong muốn
```
sourcery --sources AutoEquatable.playground/Sources \
--output AutoEquatable.playground/Sources \
--templates . \
--watch
```
Kết quả:

```swift
extension Person: Equatable {
    public static func ==(lhs: Person, rhs: Person) -> Bool {
        guard lhs.name == rhs.name else { return false }
        guard lhs.age == rhs.age else { return false }
        guard lhs.gender == rhs.gender else { return false }
        
        return true
    }
}
```