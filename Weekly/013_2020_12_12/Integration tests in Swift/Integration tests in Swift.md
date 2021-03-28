[Original Link](https://www.swiftbysundell.com/articles/integration-tests-in-swift/)

# Integration tests in Swift
## Introduction
Bài viết giới thiệu về Integration Test và có minh hoạ nó bằng vài đoạn code ví dụ bằng Swift.

## Integration of multiple units
Tất cả code base về cơ bản đều có thể chia thành nhiều phần khác nhau, ở cả mức high-level như là Search, Login, Networking,v.v… hoặc ở mức low-level hơn rất nhiều như là các class hoặc function. 

Thông thường để test các thành phần này ta có thể dùng unit test và test từng phần (hoặc unit) in isolation. Các unit nên càng nhỏ càng tốt (ví dụ 1 class trong 1 feature thay vì toàn bộ feature). Chúng ta muốn giới hạn depend của unit với bên ngoài (có các kỹ thuật như DI và Mocking).

Trong khi đó, integration test lại là 1 khía cạnh khác, chúng ta muốn verify cách mà các unit thực sự tương tác với nhau. Thay vì mocking mọi thứ outside single unit, chúng ta sẽ dùng real objects để perform test và verify outcomes.

## Minh hoạ integration test
```swift
func makeTemporaryFilePathForTest(
    named testName: StaticString = #function,
    suffix: String = ""
) -> String {
    let path = NSTemporaryDirectory() + "\(testName)" + suffix
    try? FileManager.default.removeItem(atPath: path)
    return path
}

class FriendManagerIntegrationTests: XCTestCase {
    func testAddingFriendToDatabase() throws {
        // Setting up our real database using a temporary file.
        let databasePath = makeTemporaryFilePathForTest(suffix: ".db")
        let database = Database(filePath: databasePath)

        // Using the above database, plus a date provider function
        // that always returns the same date, we can now create
        // an instance of our manager.
        let date = Date()
        let manager = FriendManager(database: database, dateProvider: { date })

        // Creating instances of the models we'll use for verification
        let user = User(id: 7, name: "John")
        let friend = Friend(user: user, friendshipDate: date)

        // Just like in our unit test, we want to verify that
        // our initial state is what we expect — just to make
        // sure that our database is indeed empty.
        XCTAssertNil(try? database.loadEntity(withID: friend.id) as Friend)

        // Performing our test action
        try manager.becomeFriends(with: user)

        // Verifying the outcome of the above action
        let loadedFriend = try database.loadEntity(withID: friend.id) as Friend
        XCTAssertEqual(loadedFriend, friend)
    }
}
```
Như ví dụ trên là ta đang test việc thêm 1 friend mới vào FriendManager, nhưng ở đây ta không dùng Mocking Database mà dùng __Real Database__ để test.
Verify outcome cũng sẽ dùng outcome từ database để verify. Do đó, ta đã thực sự test được việc integration Databse vào FriendManager.
Dĩ nhiên ta không thể sử dụng Live Data để test cho nên ta vẫn sẽ có 1 bước setup tạo ra 1 tempory file.


