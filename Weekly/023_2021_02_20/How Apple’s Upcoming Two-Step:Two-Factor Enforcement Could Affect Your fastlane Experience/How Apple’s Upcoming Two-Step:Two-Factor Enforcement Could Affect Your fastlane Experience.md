[Original Link](https://www.joshholtz.com/blog/2021/02/17/apples-2fa-with-fastlane.html)

# How Apple’s Upcoming Two-Step/Two-Factor Enforcement Could Affect Your fastlane Experience

## Introduction
Bài viết trình bày về những thay đổi đối với Apple ID có thể làm ảnh hưởng đến fastlane. Kể từ tháng 2/2021, các Apple ID account khi sign in vào AppStore Connect sẽ đòi hỏi phải bật __Two-Steps Verification (2SV)__ hoặc __Two-Factor Authentication (2FA)__. Điều này rõ ràng sẽ ảnh hưởng đến fastlane nếu fastlane có login bằng Apple ID để tương tác với App Store Connect.

## Run fastlane trên CI
Nếu chúng ta chỉ run fastlane locally thì vấn đề cũng không quá nghiêm trọng vì chúng ta có thể tự mình nhập code từ 2SV/2FA vào CLI khi được yêu cầu.
Tuy nhiên, nếu fastlane được dùng để run trên CI thì chúng ta không thể làm như vậy được. Ta sẽ có 2 option

#### _Option 1: Tiếp tục sử dụng Apple ID nhưng với pre-generated session_

```sh
Run: fastlane spaceauth 
```
Sau đó ta cần nhập code từ 2SV/2FA và output của command này sẽ cần được lưu vào environment variable __FASTLANE_SESSION__
Session này sẽ valid trong khoảng 15-30 ngày và sau đó chúng ta sẽ cần phải chạy lại command (và nhập lại code 2SV/2FA) để gen ra lại session mới. 

#### _Option 2: Migrate đến AppStore Connect API key_
Đây là cách được recommend hơn cách 1, thay vì tiếp tục dùng Apple ID, chúng ta sẽ chuyển qua dùng AppStore Connect API key.
Thay vì dùng __username__ option hoặc __FASTLANE_USER/FASTLANE_PASSWORD__ environment variables, chúng ta có thể chuyển qua dùng __api_key, api_key_path_option__ hoặc __APPSTORE_CONNECT_API_KEY, APPSTORE_CONNECT_API_KEY_PATH__ variables.

Đa phần các tools, actions đã hỗ trợ các option mới này 
* Tools: _cert, deliver, match, pilot, precheck, sigh_
* Actions: _app_store_build_number, latest_testflight_build_number, register_device, register_devices, set_changelog_

Tuy nhiên, _custom spaceship code, produce, pem,_ hoặc _download_dsyms_ vẫn chưa được support đầy đủ AppStore Connect API key

## Other changes có thể cần thực hiện
##### Khi nào download_dsyms?
Run locally hoặc ở 1 job khác. Job này có thể run 1 lần mỗi ngày hoặc vài lần mỗi tuần.

##### Có thực sự cần Apple ID hoặc AppStore Connect API?
__match__ với read-only mode cho signing, không cần đến auth. __gym__ cũng không cần auth để build và sign app.
Uploading binary lên AppStore hoặc Testflight, có thể dùng __deliver__ hoặc __pilot__ với __FASTLANE_APPLICATION_SPECIFIC_PASSWORD__ cũng không cần đến Apple ID hoặc AppStore Connect API Key.

##### produce và pem không fully work với AppStore Connect API key
2 tools này vẫn còn cần đến Apple ID.
* _produce:_ tạo ra new iOS app trên AppStore Connect và Apple Developer Portal
* _pem:_ tự động generate và renew push notification profile
