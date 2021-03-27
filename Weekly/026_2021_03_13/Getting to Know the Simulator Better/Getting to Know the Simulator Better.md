[Original Link](https://www.andyibanez.com/posts/getting-to-know-the-simulator-better/)

# Getting to Know the Simulator Better

## Introduction
This post talks about using simulator through command line commands.

## Listing simulator devices
```sh
xcrun simctl list
```
## Booting device
```sh
xcrun simctl boot 0DD83491-914D-4EB9-9B8A-00A3191199B7
```
## simctl with JSON
```sh
xcrun simctl list --json
```
## Shutting down and Clearing Simulators
```sh
xcrun simctl shutdown SIMULATOR_UUID
```
```sh
xcrun simctl erase SIMULATOR_UUID
```
## Opening URLs in Simulator
```sh
xcrun simctl openurl (SIMULATOR_UUID|booted) maps://
```
```sh
xcrun simctl openurl (SIMULATOR_UUID|booted) "https://www.andyibanez.com"
```
## Screenshots and Videos
```sh
xcrun simctl io SIMULATOR_UUID|booted screenshot FILE_NAME.png
```
```sh
xcrun simctl io booted SIMULATOR_UUID|booted recordVideo FILE_NAME.mp4
```
## Adding Media to Photos.app
```sh
xcrun simctl addmedia SIMULATOR_UUID|booted ~/path/to/file/pic.jpg
```
## Privacy
```sh
xcrun simctl privacy SIMULATOR_UUID|booted grant APP_NAME YOUR_APP_BUNDLE_ID
```
## Push notifications
```sh
xcrun simctl push SIMULATOR_ID|booted YOUR_APP_BUNDLE_ID PAYLOAD_JSON_FILE.json
```
```json
{
    "aps" : {
		    "badge" : 1, 
        "alert" : {
            "title" : "New Message",
            "body" : "Sakura: Hey I just captured a new card!"
        }
    }
}
```
## Keychain management
```sh
xcrun simctl keychain booted add-root-cert myCert.cer
```