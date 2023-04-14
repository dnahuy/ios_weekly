[Origin](https://vojtastavik.com/2016/02/17/another-world-of-notifications-darwin-notifications/)

# Another world of Notifications - Darwin Notifications
## Introduction
* All NSNotifications we send are distributed just within an app’s current process.
* CFNotificationCenter can distribute notifications across the whole system.

## CCHDarwinNotificationCenter
CFNotificationCenter is a C-based API, so using it in Swift is a bit adventurous. So we should use [CCHDarwinNotificationCenter](https://github.com/choefele/CCHDarwinNotificationCenter)
 which wraps Darwin notifications to an object based NS API.

