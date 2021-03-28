[Original Link](https://www.andyibanez.com/posts/understanding-limited-photo-library-ios-14/)

# Understanding the Limited Photo Library in iOS 14
## Introduction
Bài viết nói về __Limit Photo Library__ (1 loại permission mới liên quan đến Photo) trên iOS 14.

## Alternatives
Apple giới thiệu __PHPicker class__ trong iOS 14. Class này thay thế cho __UIImagePickerViewController__. Picker mới này sẽ cung cấp system UI cho user search library và select ảnh hoặc video. Điều quan trọng nhất là vì đây là 1 sytem prompt (thậm chí nó sẽ chạy trên 1 process khác chứ không phải app của chúng ta), user sẽ không còn bị hỏi về Permission.

## Authorization Status
__PHAuthorizationStatus__ có thêm 1 value mới là __.limited__
Có thêm 1 enum mới là __PHAccessLevel__ (only or read/write access)

## UI Considerations
Nếu user chọn limited photo permission, sau đó, mỗi lần user launch app lại và có access vào photo thì sẽ lại có 1 system prompt hiện lên để user có thể keep hoặc change selected images. Điều này có thể gây ra phiền phức, chúng ta có thể suppress nó bằng cách setting key __PHPhotoLibraryPreventAutomaticLimitedAccessAlert__ trong info.plist

System prompt sẽ không còn hiện lên nữa nhưng về mặt UI chúng ta nên có vài thay đổi để cho phép user có thể chủ động change limited nếu muốn thay vì cứ phải vào Settings app để chỉnh. Trên UI, chúng ta nên có 1 button để user có thể trigger system prompt. Chúng ta có thể call method __presentLimitedLibraryPicker(from:)__

