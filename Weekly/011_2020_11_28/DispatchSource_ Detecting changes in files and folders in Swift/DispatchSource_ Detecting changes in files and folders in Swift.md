[Original Link](https://swiftrocks.com/dispatchsource-detecting-changes-in-files-and-folders-in-swift.html)

# DispatchSource: Detecting changes in files and folders in Swift
## Introduction
Bài viết hướng dẫn cách detect file hoặc folder change

## DispatchSource
DispatchSource giúp chúng ta detect các low-level system events
* imer sources
* Signal sources
* Descriptor sources
* Process sources
* Mach port sources
* Custom sources

## Monitoring File Changes

#### Tạo ra DispatchSource
```swift
self.fileHandle = try FileHandle(forReadingFrom: url)

source = DispatchSource.makeFileSystemObjectSource(
    fileDescriptor: fileHandle.fileDescriptor,
    eventMask: .extend,
    queue: DispatchQueue.main
)
```
#### Register event notification
```swift
source.setEventHandler {
    let event = self.source.data
    self.process(event: event)
}
```
#### Register cancel event notification
```
    //init()...
    source.setCancelHandler {
        try? self.fileHandle.close()
    }
```
```swift
deinit {
    source.cancel()
}
```