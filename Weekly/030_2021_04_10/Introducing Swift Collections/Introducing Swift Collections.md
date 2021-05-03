[Original Link](https://swift.org/blog/swift-collections/)

# Introducing Swift Collections
## Introduction
This post talks about Swift Collections, a new open-source package focused on extending the set of available Swift data structures.
The initial version of the Collections package contains implementations for three data structures
1. Double-ended queue (or ___“deque”___, for short).
2. Ordered set 
3. Ordered dictionary.

## Deque
The main benefit of __Deque__ over __Array__ is that it supports efficient insertions and removals at both ends.

```swift
var colors: Deque = ["red", "yellow", "blue"]

colors.prepend("green")
colors.append("orange")
// `colors` is now ["green", "red", "yellow", "blue", "orange"]

colors.popFirst() // "green"
colors.popLast() // "orange"
// `colors` is back to ["red", "yellow", "blue"]
```
## OrderedSet
```swift
let buildingMaterials: OrderedSet = ["straw", "sticks", "bricks"]

for i in 0 ..< buildingMaterials.count {
  print("Little piggie #\(i) built a house of \(buildingMaterials[i])")
}
// Little piggie #0 built a house of straw
// Little piggie #1 built a house of sticks
// Little piggie #2 built a house of bricks
```

__OrderedSet__ uses a standard array value for element storage.
```swift
func buildHouses(_ houses: Array<String>)

buildHouses(buildingMaterials) // error
buildHouses(buildingMaterials.elements) // OK
```

## OrderedDictionary
```swift
let responses: OrderedDictionary = [
  200: "OK",
  403: "Forbidden",
  404: "Not Found",
]

responses[500] = "Internal Server Error"

for (code, phrase) in responses {
  print("\(code) (\(phrase))")
}
// 200 (OK)
// 403 (Forbidden)
// 404 (Not Found)
// 500 (Internal Server Error)

responses[0] // nil (key-based subscript)
responses.elements[0] // (200, "OK") (index-based subscript)
```

