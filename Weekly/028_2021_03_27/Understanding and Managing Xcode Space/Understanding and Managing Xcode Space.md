[Original Link](https://www.raywenderlich.com/19998365-understanding-and-managing-xcode-space)

# Understanding and Managing Xcode Space
## Introduction
This post talks about XCode space and how to remove some space to get more free storage.

## Tools and Directories
* Derived data
* Caches
* Old archives
* Unavailable simulators
* Device support files

They are not only eat into Mac’s storage but also be a source of strange bugs and compilation issues. Sometimes, we must delete Derived Data to fix compile errors. 

## Derived Data
XCode uses Derived Data to quicken build time. Everything in DerivedData is safe to delete.

## Archives
They’re the finished product of building the app. Sometimes, we should save some old archives. If we need to re-release an old archive, we need the .xcarchive that’s stored in the archives folder.
Also, debugging live versions of an app requires a certain file called a dSYM that’s packaged in archive.
So a good recommendation is to not delete any archives for versions of apps that are currently live.

## Simulator
We can erase Simulator Content (example: Saved Photos, v.v...). Besides, we also remove unavailable simulators.

## Device Support
Whenever attaching a physical device to install or debug, Xcode creates device support files. Xcode uses these files to support developer functionality, like viewing crash logs. Device support files are specific to each version of iOS, even minor versions. Xcode will never delete these files but it's safe to delete them. Any time we use a physical device, Xcode installs the device support files automatically.

## Caches
A cache stores data so programs using the cache can run faster, without needing to recompute data in the cache.
If you’re having trouble with Xcode or one of its related tools, clearing caches can help with this as well.
Find Xcode’s cache at ~/Library/Caches/com.apple.dt.Xcode.

## Supporting Caches
Caches of CocoaPods and Carthage

## Script

```sh
#!/usr/bin/env bash

# 1
echo "Removing Derived Data..."
rm -rf ~/Library/Developer/Xcode/DerivedData/

# 2
echo "Removing Device Support..."
rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
rm -rf ~/Library/Developer/Xcode/watchOS\ DeviceSupport
rm -rf ~/Library/Developer/Xcode/tvOS\ DeviceSupport

# 3
echo "Removing old simulators..."
xcrun simctl delete unavailable

# 4
echo "Removing caches..."
rm -rf ~/Library/Caches/com.apple.dt.Xcode
rm -rf ~/Library/Caches/org.carthage.CarthageKit

# 5
if command -v pod  &> /dev/null
then
    # 6
    pod cache clean --all
fi

echo "Done!"
```












