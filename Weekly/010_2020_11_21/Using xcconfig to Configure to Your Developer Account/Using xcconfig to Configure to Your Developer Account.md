[Original Link](https://samwize.com/2020/11/20/using-xcconfig-to-configure-to-your-developer-account/)

# Using xcconfig to Configure to Your Developer Account
## Introduction
Bài viết giới thiệu về cách custom __Development Team__ và __Bundler Identifier__ thông qua __xcconfig__

## xcconfig
```sh
DEVELOPMENT_TEAM = ORIGINAL_TEAM_ID
ORGANIZATION_IDENTIFIER = com.originalcompany

#include? "DeveloperSettings.xcconfig"
```

## DeveloperSettings.xcconfig
```sh
DEVELOPMENT_TEAM = YOUR_TEAM_ID
ORGANIZATION_IDENTIFIER = com.yourcompany
```

## Confiure project
```sh
* Project -> Configurations -> set configuration file đến xcconfig
* Build settings -> remove Development Team
* Change Product_Bundler_Identifier thành "$(ORGANIZATION_IDENTIFIER).xxxx”
```