[Original Link](https://betterprogramming.pub/10-tips-to-run-swift-from-your-terminal-b5832cd9cd8c)

# 10 Tips to Run Swift From Your Terminal
## Introduction
Bài viết giới thiệu về các command để run swift từ terminal

## 1. Get swift version
```sh
$ swift --version
```

## 2. Run swift file
```sh
$ swift Foo.swift
```


## 3. Run swift file với parameters
```sh
$ swift Foo.swift Foo
```

## 4. Dùng swiftc để tạo executable file
Có 2 steps để tạo ra 1 Swift executable file: compile và link. Ngoài ra, cách dễ nhất là ta chỉ cần dùng 1 single command
```sh
$ swiftc Foo.swift
```

## 5. Dùng swiftc để tạo object file
```sh
$ swiftc -c Foo.swift
$ swiftc -c Foo.swift -o Main.o
```

## 6. Link multiple objects để tạo thành module
Rename Foo.swift thành main.swift vì main.swift là file duy nhất được phép đặt executable expression foo()
```sh
$ mv Foo.swift main.swift
```

Compile
```sh
$ swiftc -c main.swift Event.swift -module-name Foo
```

Link object file để tạo thành exexutable module
```sh
$ swiftc -emit-executable main.o Event.o -o Foo
```

Để run
```sh
$ ./Foo Foo
```

## 7. Import framework khi compile swift file
Compile:
```sh
$ swiftc -c MyView.swift -o MyView.o -sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS14.1.sdk -target arm64-apple-ios14.1
```

Link:
```sh
$ swiftc -emit-executable MyView.o -sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS14.1.sdk  -target arm64-apple-ios14.1
```

## 8. Tạo ra executable swift package
Init:
```sh
$ swift package init --type executable
```

Package được tự động gen ra như sau:
```
|- Package.swift
|- README.md
|- .gitignore
|- Sources
    |- Package
        |- main.swift
|- Tests
    |- LinuxMain.swift
    |- PackageTests
        |- PackageTests.swift
        |- XCTestManifests.swift
```

```sh
$ swift build
$ swift run
$ swift test
```

## 9. Dùng Swift RELP để thử nghiệm Swift
RELP (read-evaluate-loop-print) có thể được dùng để chạy thử Swift theo 1 cách gần gần giống như 1 ngôn ngữ thông dịch (gõ lệnh -> enter).

Đầu tiên phải mở Terminal app và gõ 
```sh
$ swift
```

Input swift code gõ enter và xem nó được compile và run
```sh
1> let name = "Foo"
name: String = "Foo"
2> print(name)
Foo
```

Để thoát khỏi RELP
```sh
1> :quit
```

## 10. Sử dụng LLDP debugger
```sh
$ swiftc -g main.swift Event.swift
```
Dùng command swiftc với -g flag sẽ gen ra executable file với debug information đi kèm

```sh
|- main.swift
|- Event.swift
|- main.dSYM
|- main
```

Run main executable bằng LLDB debugger
```sh
$ lldb main Foo
```

Set breakpoint tại dòng thứ 3
```sh
(lldb) b 3
```

Run process. Process sẽ dừng tại breakpoint dòng thứ 3
```sh
(lldb): r
```

In ra giá trị của name
```sh
(lldb): p name 
```