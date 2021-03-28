[Original Link](https://somestay.medium.com/ios-app-clips-reduce-size-9d915c0ecc47)

# iOS App Clips reduce size
## Introduction
Bài viết chia sẻ kinh nghiệm của tác giả trong việc giảm size của AppClip.

## Xem size của AppClip
Tạo adhoc provisioning profile, sign app và export (chọn All compatible device variants và Rebuild from Bitcode), sau đó ta mở file ___App Thinking Size Report.txt___. Cuối file này sẽ có size của AppClip.

## Giảm size của AppClip
#### Frameworks
Đầu tiên tác giả remove hết tất cả những framework không cần thiết: __Firebase Crashlytics, YandexMobileMetrica, PhoneNumberKit__ và 1 vài cái khác, kết quả là giảm được 17.2 MB.
Sau đó tác giả xem xét thay 1 vài framework khác. Trong trường hợp này, ta giả đã gỡ bỏ __KingFisher__ và thay bằng native implementation.

#### Images
Tác giả xác định tất cả những images chỉ được dùng trong AppClip và tạo ra 1 Assets folder riêng biệt để chứa những images đó từ main Assets, do đó trong tổng số 92 images, chỉ giữa lại 28 images và giảm được 2.3 MB.

#### Useless files
Trong Build Phase, delete những file không cần thiết và do đó giảm từ 523 file trong main target xuống còn 304 file cho AppClip target. Đối với các Localization, tác giả cũng làm tương tự như images, tạo ra 1 file riêng biệt dành riêng cho AppClip và loại bỏ hết những thứ không cần thiết.