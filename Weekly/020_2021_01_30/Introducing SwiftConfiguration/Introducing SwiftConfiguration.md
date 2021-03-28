[Original Link](https://betterprogramming.pub/introducing-swiftconfiguration-c3cba2002965)

# Introducing SwiftConfiguration
## Introduction
Bài viết giới thiệu về SwiftConfiguration, là 1 Build Phase Script:
* ___Tự động hoá___ việc setup các configurations
* ___Validate___ các configuration file ngay lúc compile time, vì vậy chúng ta có thể yên tâm rằng app sẽ không bị crash lúc run time khi fetching configuration variables
* ___Generate ra Swift wrapper class___ để chúng ta có thể an toàn fetch các configuration variables sử dụng auto complete (tương tự SwiftGen cho resources). 