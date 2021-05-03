[Original Link](https://xcode-tips.github.io/)

# Xcode Tips 💡
## Introduction
This post talks about useful Xcode Tips which we can apply
## Breakpoints
#### Use breakpoints as __"bookmarks"__

#### Quickly toggling breakpoints
⌘ \ 

#### Play sound files in breakpoints

#### Automate user actions with LLDB expressions
We can use breakpoints to speed up iterations by simulating user actions, instead of modifying or hacking code that you might forget to remove later. 

Using breakpoints this way instead of adding temporary debug or development code eliminates the possibility of shipping that code by accident.

For example, on a login screen, you can set a breakpoint on __viewDidLoad()__, or __view{Will|Did}Appear()__, then edit the breakpoint to add a Debugger Command action to invoke other methods in the view controller, like a __loginSuccess()__ method.

## Build Times
#### Fix slow codesigning
```sh
trim ~/Library/Preferences/com.apple.security.plist
```

#### Copying framework headers
flag _RemoveHeadersOnCopy_ in _project.pbxproj_

## Code
#### Generating class initializers
Selecct class name -> Editor menu -> Refactor > Generate Memberwise Initializer.

#### Selecting blocks of code
Double click a brace to select the entire block of code it contains.

#### Apply all fix-its
Fix All Issues (⌃⌥⌘ F) to apply fix-its all at once.

## Crashes
#### Viewing .crash files

## Debugging
#### NSDoubleLocalizedStrings and Friends
__NSDoubleLocalizedStrings__ repeats the text of each localized string, making it double-length so that we can test whether your layout still works.

## Interface Builder
#### [Xcode Interface Builder Tips](https://useyourloaf.com/blog/xcode-interface-builder-tips/)
#### [More Interface Builder Tips And Tricks](https://useyourloaf.com/blog/more-interface-builder-tips-and-tricks/)

## Keyboard Shortcuts
#### Jump to a specific line
⌘L

#### Reindenting/Formatting code
⌃I

#### Adding comments quickly
⌘/ to toggle comments
⌥⌘/ directly before a method to generate a documentation comment.

#### Jump to file in source navigator
⌘⇧J 

#### Open the jump bar
⌃6

#### Remapping unhelpful keys
⇧⌘P is useless shortcuts(for the never times you want to print code.) We can remove unhelpful keys or can even remap things like ⌘P to resuming SwiftUI’s preview.

#### Increase or decrease editor font size
⌘+ or ⌘-

#### Move cursor to the top or bottom of the file
⌘↑ or ⌘↓

#### Show and hide debug area
⌘⇧Y

#### Generating an interface file
⌃⌘⇧

#### Trigger Custom Behaviors

#### Open Human Interface Guidelines

## Refactoring
#### Faster Xcode Rename Refactoring
```sh
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0
```

## Search
#### Deleting search results

## Settings
#### Customizing the file header comment and other text macros
1. Create IDETemplateMacros.plist.
2. For every text macro we want to customize, add a new key to the plist’s dictionary.
3. Copy the file to one of the following locations.
    1. <Name>.xcodeproj/xcshareddata/
    2. <Name>.xcworkspace/xcshareddata/
    …

#### Improving the assistant editor

#### Navigation using the assistant editor
* ⌘⌥ open the current location in the neighbouring editor.
* Hold ⌘⌃⌥ and click on any method to jump to that method in the neighbouring editor (⌘⌃ opens in the current editor)
* ⌘⌃↑ to switch between associated files, and ⌘⌃⌥↑ to do so using the neighbouring editor
* ⌘⌃← and ⌘⌃→ to move back and forward through navigation history, add ⌥ for their neighbouring editor counterparts

#### Spelling and Grammar
Edit > Format > Spelling and Grammar

#### Using behaviors to improve debugging

## Simulator
#### Tiling the simulator

#### Status bars
```sh
simctl status_bar
```

## Testing
#### Re-run your last test
⌃⌥⌘G 

#### Randomizing test order

#### Improving UI test reliability
We can disable or speed-up animations, and increase timeouts for __waitForExistence()__.

#### Testing in-app purchases

## Usability
#### Expanding autocomplete

#### Fix Freezing

## User Defaults
#### Make Xcode’s Assistant aware of your ViewModels, Views, etc
```sh
defaults write com.apple.dt.Xcode IDEAdditionalCounterpartSuffixes -array-add "ViewModel" "View" "Screen"
```

#### Prevent restoring the last open project
```sh
defaults write com.apple.dt.Xcode ApplePersistenceIgnoreState -bool YES
```

#### Show project build times in the activity viewer
```sh
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES
```

#### Enable Internal Debug Menu
```sh
defaults write com.apple.dt.Xcode ShowDVTDebugMenu -bool YES
sudo touch /Applications/Xcode.app/Contents/Developer/AppleInternal/Library/Xcode/AppleInternal.plist
```

## Xcode Versions
#### Quickly switching between Xcodes

#### Install, manage and switch between different Xcode versions

























