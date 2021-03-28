[Original Link](https://medium.com/azimolabs/parallel-testing-get-feedback-earlier-release-faster-b66d4dd08930)

# Parallel testing: get feedback earlier, release faster
## Introduction
Ta có thể chạy các UI Testing 1 cách song song trên nhiều devices hoặc simulator cùng lúc -> giúp tiết kiệm thời gian. XCode 9 đã bắt đầu hỗ trợ parallel testing tuy nhiên chỉ cho các device và yêu cầu chúng ta sử dụng command line. XCode 10 đã hỗ trợ parallel UI test cho các simulator

## Lấy danh sách ID của tất cá connected devices và simulators
```sh
xcrun instruments -s devices
```

## Chạy cùng 1 bộ test cho các device -> giúp test trên nhiều máy nhưng rõ ràng là không giúp tiết kiệm thời gian
```sh
xcodebuild \
 -scheme Azimo \
 -destination id={deviceID1} \
 -destination id={deviceID2} \
 test
```

## Chia nhỏ bộ test
Ta có thể chia tập test ra và cho các devices chạy từng phần khác nhau để tiết kiệm thời gian
#### Đầu tiên, build testing project
```sh
xcodebuild -project Azimo.xcodeproj -scheme Azimo -destination id={deviceID} build-for-testing
```

#### Chia nhỏ các test case cho các device
```sh
xcodebuild \
 -scheme Azimo \
 -destination id={deviceID1} \
 -only-testing: Azimo/login_tests \
 -only-testing: Azimo/register_tests \
test-without-building &
xcodebuild \
 -scheme Azimo \
 -destination id={deviceID2} \
 -only-testing: Azimo/createRecipient_tests \
 -only-testing: Azimo/createTransfer_tests \
 test-without-building &
```