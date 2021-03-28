[Original Link](https://sarunw.com/posts/how-expensive-is-dateformatter/)

# How expensive is DateFormatter
## Introduction
Bài viết trình bày về cách sử dụng __DateFormatter__ hiệu quả. Nội dung chủ yếu là test đo performance của DateFormatter trong những tình huống thường gặp.

## Conclusion
Qua thử nghiệm kết luận được rút ra:
* Create hoặc change property của DateFormatter sẽ rất cost, ta nên create 1 lần và tái sử dụng nó cũng tránh việc change change các property của nó (timeZone, dateFormat, calendar, v.v…)
* Hàm string(from: Date) rất cheap nhưng ngược lại hàm date(from: String) sẽ rất cost