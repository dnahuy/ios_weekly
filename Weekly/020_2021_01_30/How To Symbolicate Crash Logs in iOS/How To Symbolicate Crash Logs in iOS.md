[Original Link](https://betterprogramming.pub/how-to-symbolicate-crash-logs-in-ios-b05637591364)

# How To Symbolicate Crash Logs in iOS
## Introduction
Bài viết giới thiệu về cách symbolicate crash logs trên iOS

## Crash logs
Khi app crash, system sẽ generate ra __crash log__ và lưu trên device. Thông tin sẽ được lưu dưới dạng __hexadecimal address__, vì vậy nó cần được translate thành tên hàm và line number thông qua 1 quá trình gọi là __symbolication__.

## Cách lấy crash log
Testflight và AppStore sẽ thu thập crash report cho mỗi version đã được submit. Testflight users sẽ tự động share crash reports.
Crash reports sẽ hiện lên ở Crash Organizer. Nếu không tìm thấy nó, chúng ta có thể tìm trực tiếp trên device bằng cách vào 
```
Settings -> Privacy -> Analytics & Improvement -> Analytics Data.
```

## dSym file
Nếu app đã được submit lên Testflight hoặc AppStore, chúng ta có thể get được dsym file từ AppStore connect. Ngoài ra, ta cũng có thể get từ XCode Archives.
Đối với xcarchive, chúng ta phải chọn dsym file có title match với build UUID của binary mà bạn muốn symbolicate. Để tìm UUID, chúng ta có thể mở file crash log và search slice_uuid

## symbolication
Câu lệnh:
```sh
atos -arch <Binary Architecture> -o <Path to dSYM file>/Contents/Resources/DWARF/<binary image name> -l <load address> <address to symbolicate>
```
Ví dụ:
```sh
atos -arch arm64 -o dSYMs/D1ABC7F3-E81D-3264–847E-4FB2578B43DD.dSYM/Contents/Resources/DWARF/CrashLogExample -l 0x100bb0000 0x0000000100bb6080
```

Tuy nhiên nếu file .ipa đã được enable ___bitcode___ thì ta cần phải làm thêm 1 bước nữa để có thể khôi phục lại obfuscated dSym file. Chúng ta sẽ cần dùng thêm 1 file được gọi là ___symbol map___ cũng được XCode gen ra trong quá trình archiving app.
```sh
dsymutil -symbol-map <path to BCSymbolMaps> <path to dSYM file>
```
Ví dụ:
```sh
dsymutil -symbol-map CrashLogExample.xcarchive/BCSymbolMaps dSYMs/D1ABC7F3-E81D-3264–847E-4FB2578B43DD.dSYM
```
Sau đó, ta chạy lại lệnh atos 1 lần nữa thì sẽ có thể get được function names và line numbers.