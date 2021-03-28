[Original Link](https://medium.com/dev-genius/how-to-fix-your-ci-to-avoid-apple-2fa-e1b101555dc1)

# How to Fix Your CI to Avoid Apple’s 2FA
## Introduction
Bài viết hướng dẫn về việc dùng AppStore Connect API để có thể vượt qua __2FA (Two-Factor Authenticaton)__ của Apple.

## Apple 2FA
Các developer với Account Holder role sẽ bắt buộc phải enable 2FA để sign-in vào _Apple Developer account & Certificates, Identifiers and Profiles._
Điều này khiến cho các CI dùng __username/password__ sẽ không còn work được nữa. Ta có thể vượt qua trở ngại này bằng cách chuyển sang dùng AppStore Connect API.

## Fastlane
Fastlane đã hỗ trợ new AppStore Connect API trong 1 số API như: pilot, deliver, sigh, cert, match, v.v….

## AppStore Connect API
Để có thể dùng AppStore Connect API, chúng ta sẽ cần: key id, issuer id, .p8 file.
Ta có thể gen từ link này: https://appstoreconnect.apple.com/access/api/new

## Update Lanes in Fastfile
Ví dụ, ta sẽ sử dụng pilot với new API

```sh
lane :testflight_upload do
  gym(… configuration params …)
  api_key = app_store_connect_api_key(
    key_id: “Your Key id”,
    issuer_id: “Your Issuer Id”,
    key_filepath: “.p8 File path”
  )
  pilot(api_key: api_key, 
        … more configuration params …
  )
end
```
