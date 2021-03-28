[Original Link](https://masilotti.com/xctest-name-readability/)

# Improving XCTest test name readability
## Introduction
Bài viết giới thiệu về 1 cách để đặt tên các func trong XCTestCase

## XCTestCase
Như đã biết, Apple quy định đặt tên func phải bắt đầu bằng __“test”.__
```swift
class NetworkReachabilityTests: XCTestCase {
    func testUnreachableURLAccessThrowsAnError()
    func testUserJSONFeedParsing()
}
```
Nhưng đôi khi sẽ rất khó để đặt tên func sao cho thể hiện hết được ý nghĩa của test đó.
Tác giả Jon Reid đề xuất 1 cách đặt tên func như sau: tên của test case sẽ được chia thành 3 phần
1. ___Given:___ operation được test
2. ___When:___ điều kiện
3. ___Then:___ kết quả mong muốn

```swift
func test_givenSomething_whenSomething_thenSomething()
func test_numberOfCells_withNoData_isZero()
```
Readability đã tăng lên 1 chút

## XCContent và XCActivity

```swift
class TestCase: XCTestCase {
    func test_numberOfCells() throws {
        XCTContext.runActivity(named: "is zero when there is no data") { _ -> Void in
            /* ... */
        }

        XCTContext.runActivity(named: "is equal to the number of items") { _ -> Void in
            /* ... */
        }
    }
}
```

Như đoạn code trên ta có thể thấy ta đã move được phần __When__ và __Then__ ra khỏi tên func và thay bằng 1 đoạn text mô tả.

## Viết gọn hơn bằng extension
Ta có thể dùng extension để có thể viết gọn hơn nữa
```swift
extension XCTestCase {
    func test<T>(_ description: String, block: () throws -> T) rethrows -> T {
        try XCTContext.runActivity(named: description, block: { _ in try block() })
    }
}

class TestCase: XCTestCase {
    func test_numberOfCells() throws {
        test("is zero when there is no data") {
            /* ... */
        }

        test("is equal to the number of items") {
            /* ... */
        }
    }
}
```

## Trade-offs
Cách viết có thể tăng readability tuy nhiên bù lại sẽ có những nhược điểm sau:
* Chỉ generate ra 1 test (như đoạn code trên thì đáng lẽ phải là 2 test).
* Khi run test bắt buộc phải run hết các activity
* Cần thêm 1 “nested” layer: Class -> func -> activity

## Quick Library
Ngoài ra, ta có thể dùng Quick là 1 testing library giúp viết test theo kiểu BDD-style.

```swift
class TableOfContentsSpec: QuickSpec {
  override func spec() {
    describe(“the ‘Documentation’ directory”) {
      it(“has everything you need to get started”) {
        let sections = Directory(“Documentation”).sections
        expect(sections).to(contain(“Organized Tests with Quick Examples and Example Groups”))
        expect(sections).to(contain(“Installing Quick”))
      }

      context(“if it doesn’t have what you’re looking for”) {
        it(“needs to be updated”) {
          let you = You(awesome: true)
          expect{you.submittedAnIssue}.toEventually(beTruthy())
        }
      }
    }
  }
}
```