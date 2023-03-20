[Origin](https://doordash.engineering/2019/05/22/ios-memory-leaks-and-retain-cycle-detection-using-xcodes-memory-graph-debugger/)

# How to detect iOS memory leaks and retain cycles using Xcode’s memory graph debugger
## Introduction
How DoorDash iOS team uses Memory Graph Debugger and avoids leaking memory 

## Retain Cycles and Memory Leaks
* **Retain Cycle:** Two or more objects hold strong references to each other
* **Memory Leak:** An amount of allocated space in memory cannot be deallocated due to retain cycles

## OOM crash and Side Effects
* **Out-of-Memory** causes crashing app
* **Side Effects:** Leaked observers would still listen to notifications and when triggered, the app would be prone to unpredictable behaviors or crashes

## Xcode’s Memory Graph Debugger
Please note that the Xcode’s auto-detection does not always catch every memory leak, and oftentimes you will have to find them yourself.

## The approach to using the Memory Graph Debugger
Running the app through some core flows and taking a memory snapshot for the first and subsequent iterations

## Example


## Additional tips
