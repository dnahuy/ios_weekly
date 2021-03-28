[Original Link](https://onmyway133.com/blog/how-to-add-alternative-app-icons-for-ios/)

# How to add alternative app icons for iOS
## Introduction
Bài viết hướng dẫn về cách change app icon động.

## App Icons
Đối với các app icon, ta nên chuẩn bị 2 version là 2x và 3x. Lưu ý, ta không được add vào Asset Catalog mà phải add vào Project (có thể là vào thư mục Resources nếu có).
Ví dụ:
_first@2x.png, first@3x.png, second@2x.png, second@3x.png_

## info.plist
Ta tạo thêm 1 key là ___CFBundleIcons___
Ví dụ:

```xml
<key>CFBundleIcons</key>
	<dict>
		<key>CFBundlePrimaryIcon</key>
		<dict>
			<key>CFBundleIconFiles</key>
			<array>
				<string>AppIcon</string>
			</array>
			<key>UIPrerenderedIcon</key>
			<false/>
		</dict>
		<key>CFBundleAlternateIcons</key>
		<dict>
			<key>AppIcon2</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>second</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
		</dict>
	</dict>
```

## Code
Để change icon, ta phải gọi __UIApplication.shared.setAlternateIconName__ nếu icon name ta truyền  vào là nil thì app sẽ lấy primary icon. Lưu ý, hàm này ta phải gọi theo kiểu async

Ví dụ:
```swift
DispatchQueue.main.async {
    UIApplication.shared.setAlternateIconName("AppIcon2")
}
```
