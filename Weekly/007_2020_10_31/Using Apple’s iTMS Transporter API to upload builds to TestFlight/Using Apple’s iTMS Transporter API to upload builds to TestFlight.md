[Original Link](https://medium.com/ynap-tech/using-apples-itms-transporter-api-to-upload-builds-to-testflight-60dba18b07bc)

# Using Apple’s iTMS Transporter API to upload builds to TestFlight
## Introduction
Bài viết hướng dẫn automate upload file IPA lên AppStore connect bằng itms transporter.

![](resources/flow.png)

```sh
Application Loader của XCode bên dưới cũng đang dùng iTMS Transporter
/Applications/Xcode.app/Contents/SharedFrameworks/ContentDeliveryServices.framework/Versions/Current/itms/bin/iTMSTransporter
```

## Tạo ra thư mục .itmsp
Thư mục .itmsp sẽ chứa metadata.xml và file ipa cần upload.
```sh
mkdir <path to your .itmsp folder>/<name of your .itmsp folder>.itmsp
```

## Generate metadata.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://apple.com/itunes/importer" version="software5.4">
  <software_assets apple_id="Your Apple ID" app_platform="ios">
    <asset type="bundle">
      <data_file>
        <size><Size of your .ipa file></size>
        <file_name><Your .ipa file name>.ipa</file_name>
        <checksum type="md5"><Generated MD5 checksum></checksum>
      </data_file>
    </asset>
  </software_assets>
</package>
```
Lấy size của file ipa
```sh
stat -f %z <Your .ipa file>
```

Lấy MD5 checksum
```sh
md5 <Your .ipa file> | cut -d "=" -f 2 | awk '{print $1}'
```

## Upload thư mục .itmsp lên AppStoreConnect
```sh
/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/itms/bin/iTMSTransporter -m upload -u <Your username> 
-p <Your password> -f <Location of the .itmsp file> -t DAV -t Signiant -k 100000 -v eXtreme
```
