[Original Link](https://inessential.com/2021/03/20/how_netnewswire_handles_threading)

# How NetNewsWire Handles Threading
## Introduction
This post talks about [NetNewsWire](https://netnewswire.com/)'s threading model.

## Run Most Code on the Main Thread
we try, as much as possible, to not use queues or threading at all. We use main thread whenever possible

## Communicate Between Components on the Main Thread
Every notification and every callback happens on the main thread.

## Use Serial Queues for Pure Functions That Take Time
Parsing RSS, decoding JSON or Image Data are great for background processing because they're perfectly isolatable. And they take some time (though maybe few).

## Use Serial Queues for Database Access
The APIs for reading and writing is main-thread only and by a serial queues. They call back asynchronously but always on the main thread with a result. When the database code sends any notifications, it does so on the main thread.

## The result
Although, almost code run on main thread, NetNewsWire is responsive and freakishly fast. Besides, it's also the most stable and bug-free.

## Advice
Senior developers eliminate concurrency as much as possible by developing a simple, easy, consistent model to follow for the app and its components.
If we worried about blocking main thread, we could consider this: it’s easier to fix a main-thread-blocker than fixing a weird, intermittent bug or crash due to threading.
We can use __Time Profiler__ to detect main-thread blocker and figure out what’s going on.

## How-to
* Identify code that should be main-thread-only and use assert(Thread.isMainThread)
* Turn on Xcode’s Main Thread Checker
* Make sure that every Notification is posted on main thread. In notification handlers, add an assert(Thread.isMainThread)
* Find out queues those could be moved to main thread.
* When can’t move to main, make APIs that call back on main thread.