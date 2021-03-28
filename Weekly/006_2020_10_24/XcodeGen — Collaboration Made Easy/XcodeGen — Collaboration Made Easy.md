[Original Link](https://medium.com/dev-jam/xcodegen-collaboration-made-easy-9d1fdef548de)

# XcodeGen — Collaboration Made Easy
## Introduction
Giới thiệu về 1 command line tool giúp tự động gen ra file xcode project. Tool này rất hữu ích để __fix merge conflict__ trong file __.xcodeproj__

## XCodeGen
Tự động gen ra file xcode project sử dụng cấu trúc folder và 1 file project spec chứa các thông tin cần thiết.

#### project.yaml
```
name: XcodeGenSample
options:
  bundleIdPrefix: com.frontado
  deploymentTarget: 
     iOS: 13.0
targets:
  XcodeGenSample:
    type: application
    platform: iOS
    sources: 
      - path: XcodeGenSample
```

## Modular 
Ngoài ra ta còn có thể tách file config ra thành các module.

#### Main
```
name: XcodeGenSample
options:
  bundleIdPrefix: com.frontado
  deploymentTarget:
    iOS: 13.0
targets:
  XcodeGenSample:
    type: application
    platform: iOS
    sources: 
      - path: XcodeGenSample
    dependencies:
      - target: Authentication
      - target: Profile
    scheme:
      testTargets:
      - XcodeGenSampleTests
  XcodeGenSampleTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: XcodeGenSampleTests
include:
    - path: Subspecs/authentication.yml
    - path: Subspecs/profile.yml
```

#### Authentication
```
name: Authentication
options:
  bundleIdPrefix: com.frontado
  deploymentTarget:
    iOS: 13.0
targets:
  Authentication:
    type: framework
    platform: iOS
    sources: 
      - path: ../Subprojects/Authentication
    scheme:
      testTargets:
      - AuthenticationTests
  AuthenticationTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: ../Subprojects/AuthenticationTests
```		

