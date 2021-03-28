[Original Link](https://medium.com/@rick38yip/how-to-make-xcframework-fat-framework-in-xcode-da83a8450c4b)

# How to make XCFramework / Fat Framework in Xcode
## Introduction
Trước đây chúng ta thường gặp lỗi framework bên cho architecture nào thì chỉ có thể dùng cho architecture đó (ví dụ iphoneos, iphonesimulator).  Chúng ta cũng có thể build fat framework.
Từ WWDC2019, chúng ta đã có thể build __universal framework (.xcframework)__. Bài blog này chủ yếu đề xuất 1 đoạn run script build phase giúp tự động tạo ra universal framework.