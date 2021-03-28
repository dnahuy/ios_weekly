[Original Link](https://medium.com/better-programming/async-functions-are-coming-to-swift-75993d0cb4e3)

# Async Functions Are Coming to Swift
## Introduction
Bài viết giới thiệu về 1 tính năng sắp có trong Swift, đó là async/await

## Vấn đề khi dùng Closure: Pyramid of Doom
Khi có nhiều Closure lồng nhau thì code sẽ rất khó nhìn và khó maintain.

```swift
func processImageFromServer(completionBlock: (_ result: UIImage?) -> Void) {
    loadFileFromServer("myFile") { fileData in
        analyzFile(fileData) { imageData in
            decodeImage(imageData) { image in
                scaleDownImage(image) { newImage in
                    completionBlock(newImage)
                }
            }
        }
    }
}
 
processImageFromServer { image in
    self.updateUI(withNewImage: image)
}
```

## Async and Await
```swift
func processImageFromServer(string : String) async ->UIImage {
    let fileData    = await loadFileFromServer(string)
    let imageData   = await analyzFile(fileData)
    let image       = await decodeImage(imageData)
    return image
}
```
Await sẽ suspend current thread và đợi response trả về. Tuy nhiên, đối với UI thread thì nó có bị await block lại hay không?

__Giải thích__
Thật ra, nếu UI thread call 1 hàm async và dùng await, nó cũng sẽ không bị block. Hiện giờ sẽ có 2 loại hàm
* Hàm async được đánh dấu bằng keyword async
* Hàm mà trong body của nó sẽ gọi hàm async và có sử dụng await. Hàm này sẽ có keyword @asyncHandler

Ví dụ:
```swift
func loadImage() async ->UIImage? {
    do {
        print("6")
        let imageData = try Data(contentsOf: URL(string: "https://images.radio.com/myImage.png")!)
        print("7")
        return UIImage(data: imageData)
    } catch {
        
    }

    return nil
}
    
@IBAction func tapped(_ sender: Any) {
    print("1")
    startLoadImage()
    print("2")
}

@asyncHandler func startLoadImage() {
    print("3")
    if let image = await loadImage() {
        print("4")
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    print("5")
}
```

Trong ví dụ trên, hàm __loadImage()__ là hàm async, hàm __startLoadImage()__ có gọi đến hàm async __loadImage()__ và có dùng await, nên __startLoadImage()__ sẽ là __@asyncHandler__. Hàm __tapped()__ gọi đến hàm __startLoadImage()__ và sẽ không bị block.
Hàm __startLoadImage()__ sẽ được chạy trên 1 thread khác với __tapped()__ (chạy trên UI Thread)
Kết quả print ra sẽ là: 
```
1, 2, 3, 6, 7, 4, 5
```