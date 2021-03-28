[Original Link](https://www.hackingwithswift.com/articles/228/whats-new-in-swift-5-4)

# What’s new in Swift 5.4?
## Introduction
Bài viết giới thiệu về những điểm mới của Swift 5.4

## Cải tiến implicit member syntax
Thay vì chỉ hỗ trợ duy nhất 1 single static member, ta có thể tạo ra các chuỗi
Ví dụ:
```swift
let milky: UIColor = .white.withAlphaComponent(0.5) // error
```
Câu lệnh sẽ gặp error trên các Swift version cũ, nhưng sẽ work từ Swift 5.4

## Multiple variadic parameters
Ví dụ: 
```swift
func summarizeGoals(times: Int..., players: String...) {
    let joinedNames = ListFormatter.localizedString(byJoining: players)
    let joinedTimes = ListFormatter.localizedString(byJoining: times.map(String.init))

    print("\(times.count) goals where scored by \(joinedNames) at the follow minutes: \(joinedTimes)")
}

summarizeGoals(times: 18, 33, 55, 90, players: "Dani", "Jamie", "Roy")
```

## Result builders
Function Builders đã xuất hiện không chính thức từ Swift 5.1. Đến Swift 5.4, nó đã chính thức được thông qua và được đổi tên thành Result Builders.
Result builders cho phép chúng ta tạo ra 1 giá trị mới từ 1 chuỗi các components (thông qua 1 vài hàm buildBlock).
Một vài ví dụ về Result Builders

#### _Simple_

```swift
@resultBuilder
struct SimpleStringBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }
}
```
Result Builders này thực hiện thao tác đơn giản là nối các string lại với nhau.

```swift
@SimpleStringBuilder func makeSentence3() -> String {
    "Why settle for a Duke"
    "when you can have"
    "a Prince?"
}
print(makeSentence3())
```

#### _Conditional_
Ngoài dạng đơn giản nhất này, ngoài ra ta còn có thể sử dụng các hàm buildBlock khác, ví dụ như ta có thể hỗ trợ if else trong chuỗi component bằng cách sử dụng hàm _buildEither(first:)_ và _buildEither(second:)_

```swift
@resultBuilder
struct ConditionalStringBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }

    static func buildEither(first component: String) -> String {
        return component
    }

    static func buildEither(second component: String) -> String {
        return component
    }
}

@ConditionalStringBuilder func makeSentence4() -> String {
    "Why settle for a Duke"
    "when you can have"

    if Bool.random() {
        "a Prince?"
    } else {
        "a King?"
    }
}

print(makeSentence4())
```

#### _Array_

```swift
@resultBuilder
struct ComplexStringBuilder {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }

    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "\n")
    }
}

@ComplexStringBuilder func countDown() -> String {
    for i in (0...10).reversed() {
        "\(i)…"
    }

    "Lift off!"
}

print(countDown())
```

## Hỗ trợ overloading trong local function
Ví dụ:

```swift
struct Butter { }
struct Flour { }
struct Sugar { }

func makeCookies() {
    func add(item: Butter) {
        print("Adding butter…")
    }

    func add(item: Flour) {
        print("Adding flour…")
    }

    func add(item: Sugar) {
        print("Adding sugar…")
    }

    add(item: Butter())
    add(item: Flour())
    add(item: Sugar())
}
```

3 hàm ở ví dụ trên là các local function của hàm makeCookies, từ Swift 5.4, chúng ta có thể sử dụng overloading trong hàm makeCookies đối với 3 hàm add này

## Local variables đã hỗ trợ property wrapper
Swift 5.1 đã giới thiệu property wrapper và được áp dụng cho các property của class, struct, v.v… Từ Swift 5.4, ta đã có thể áp dụng property wrapper cho cả các biến local

```swift
func playGame() {
    @NonNegative var score = 0

    // player was correct
    score += 4

    // player was correct again
    score += 8

    // player got one wrong
    score -= 15

    // player got another one wrong
    score -= 16

    print(score)
}
```

Trong ví dụ trên, __@NonNegative__ là 1 property wrapper và được áp dụng cho biến score.