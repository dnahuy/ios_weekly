[Original Link](https://www.andyibanez.com/posts/modern-concurrency-in-swift-introduction/)

# Modern Concurrency in Swift: Introduction
## Introduction
Focused on the new `async/await APIs`

## Concurrency and its Problems with Current Implementations
* The need for concurrency in software be about spawning concurrent tasks to get some job done, or to speed up something. 
*  When it comes to Apple technologies, the need for concurrency is the same, but we also need to keep an eye out for the main thread to not get blocked by anything.
* Calls that have potential to freeze our main thread are all over Apple's SDKs. This is why Apple provides us with different tools to delegate work to different threads and keep our main thread free.

## Callback-based concurrency for API for consumers
```swift
let task = URLSession.shared.dataTask(with: ...) { data, response, error in
    let taskThatNeedsPreviousResponse = URLSession.shared.dataTask(with: ...) { data, response, error in
        let evenMoreNestedNetworking = URLSession.shared.dataTask(with: ...) { data, response, error in
            /// We can finally do more work here
        }
        evenMoreNestedNetworking.resume()
    }
    taskThatNeedsPreviousResponse.resume()

}

task.resume()
```
As the calls get nested and nested (and nested), it can become a problem when it comes to readability.

## Callback-based concurrency for API Designers
```swift
func fetchThumbnail(for id: String, completion: @escaping (UIImage?, Error?) -> Void) {
    let request = thumbnailURLRequest(for: id)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            completion(nil, FetchError.badID)
        } else {
            guard let image = UIImage(data: data!) else {
                return // (1)
            }
            image.prepareThumbnail(of: CGSize(width: 40, height: 40)) { thumbnail in
                guard let thumbnail = thumbnail else {
                    return // (2)
                }
                completion(thumbnail, nil)
            }
        }
    }
    task.resume()
}
```
* You are responsible for calling callback when you are done with your job. 
    - It can become overwhelming when you realize there's many edge cases you need to think of.
    - The developer calling your function can find cases in which their callback is never called.
* All the information about the `return` type and the error are part of the closure you are given.
    - You cannot have a clean API that states its return type and whether it can yield an error or not
    - There's no such thing as throwing an error. You have to provide the error in callback.

## Combine?
* Combine framework solves many of the problems above beautifully through the use of pipelines
* Combine's future is uncertain 
* It's not used enough. It may not be wise to invest much time on it untile we know what Apple's plans for it are

## A new way of thinking
* Trying to throw your current knowledge of concurrency out the window. The implementation for `async/await` is very different.

## Table of Contents
1. [Understanding async/await in Swift](https://www.andyibanez.com/posts/understanding-async-await-in-swift/)
2. [Converting closure-based code into async/await in Swift](https://www.andyibanez.com/posts/converting-closure-based-code-into-async-await-in-swift/)
3. [Structured Concurrency in Swift: Using async let](https://www.andyibanez.com/posts/structured-concurrency-in-swift-using-async-let/)
4. [Structured Concurrency With Task Groups in Swift](https://www.andyibanez.com/posts/structured-concurrency-with-group-tasks-in-swift/)
5. [Introduction to Unstructured Concurrency in Swift](https://www.andyibanez.com/posts/introduction-to-unstructured-concurrency-in-swift/)
6. [Unstructured Concurrency With Detached Tasks in Swift](https://www.andyibanez.com/posts/unstructured-concurrency-with-detached-tasks-in-swift/)
7. [Understanding Actors in the New Concurrency Model in Swift](https://www.andyibanez.com/posts/understanding-actors-in-the-new-concurrency-model-in-swift/)
8. [@MainActor and Global Actors in Swift](https://www.andyibanez.com/posts/mainactor-and-global-actors-in-swift/)
9. [Understanding async/await in Swift](https://www.andyibanez.com/posts/modern-concurrency-in-swift-introduction/posts/sharing-data-across-tasks-tasklocal-new-swift-concurrency-model)
10. [Sharing Data Across Tasks with the @TaskLocal property wrapper in the new Swift Concurrency Model](https://www.andyibanez.com/posts/understanding-async-await-in-swift/)
11. [Using AsyncSequence in Swift](https://www.andyibanez.com/posts/using-asyncsequence-in-swift/)
12. [Modern Swift Concurrency Summary, Cheatsheet, and Thanks](https://www.andyibanez.com/posts/modern-swift-concurrency-summary-cheatsheet-thanks/)
