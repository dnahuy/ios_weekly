[Original Link](https://medium.com/@sergeysmagleev/how-defer-operator-in-swift-actually-works-30dbacb3477b)

# How “defer” operator in Swift actually works
## Introduction
Tìm hiểu về cách mà defer keyword thực sự hoạt động.

## Ví dụ 
```swift
var a = "Hello"

func b() -> String {
  defer { a.append(" world") }
  return a
}

func d() -> String {
  a.append(" world")
  return a
}

a = "Hello"
print(b())
a = "Hello"
print(d())
```
Kết quả xuất ra là:
```
Hello
Hello world
```

Kết quả này cũng tương đối dễ hiểu. Ở hàm b() câu lệnh append trong defer theo đúng lý thuyết sẽ được gọi “sau” câu lệnh return. Về mặt lý thuyết, chúng ta không thể nào thực hiện bất cứ tác vụ nào sau khi hàm đã được return.

Nhưng compiler đã làm như thế nào mà có thể chạy lệnh append vào a sau khi a đã được return?. Tác giả dùng Hopper Disassembler để xem compiler đã làm gì.

Phân tích b bằng Hopper, chúng ta sẽ có 1 đoạn mã giả như sau:
```c++
int _$S05test_A01bSSyF() {
    swift_beginAccess(_$S05test_A01aSSvp, &var_18, 0x20, 0x0);
    rcx = *_$S05test_A01aSSvp;
    swift_bridgeObjectRetain(rcx);
    swift_endAccess(&var_18);
    $defer #1 ();
    rax = rcx;
    return rax;
}

int _$S05test_A01bSSyF6$deferL_yyF() {
    var_40 = Swift.String_builtinStringLiteralutf8CodeUnitCountisASCII.init(" world", 0x6, 0x1);
    swift_beginAccess(_$S05test_A01aSSvp, &var_20, 0x21, 0x0, &var_20, 0x21);
    $SSS6appendyySSF(var_40, 0x1);
    swift_endAccess(&var_20);
    rax = swift_bridgeObjectRelease(var_40);
    return rax;
}
```

Nhìn qua đoạn mã trên ta cũng có thể đoán ra được cách làm. 
Câu lệnh return mà ta thấy trong hàm b không thực sự là return của hàm. Thực tế, các câu lệnh trong defer sẽ được tách ra thành 1 hàm riêng và hàm này sẽ được gọi trước khi hàm b thực sự return và trả quyền điều khiển lại cho nơi gọi nó. 

Để giải quyết vấn đề biết a được append trong defer, thực ra là trước khi gọi đến hàm defer, ta đã tạo ra 1 local variable và chứa value của biến a ngay tại thời điểm đó. Sau khi đã “lưu” lại giá trị cần trả về, hàm defer sẽ được gọi. 

Cuối cùng câu lệnh return thực sự sẽ return local variable đó.