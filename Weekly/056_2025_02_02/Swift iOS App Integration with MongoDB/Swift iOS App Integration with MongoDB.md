[Link](https://medium.com/@amangupta007/swift-ios-app-integration-with-mongodb-complete-code-for-crud-operations-de07030d60a6)

# Swift iOS App Integration with MongoDB: Complete Code for CRUD Operations
## Introduction
How to integrate MongoDB into an iOS app using Swift

## Prerequisites
* XCode
* MongoDB server up and running

## Step 1: Set up the Xcode project:

## Step 2: Install the MongoDB Swift Driver:
* Initialize SPM
```
swift package init --type executable
```
* Update `Package.swift`
```
.package(url: "https://github.com/mongodb/mongo-swift-driver.git", from: "VERSION_NUMBER")
```

## Step 4: Create the MongoDB Manager class:

```swift
import MongoSwift

class MongoDBManager {
    let client: MongoClient
    let database: MongoDatabase

    init() throws {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        let settings = MongoClientSettings(eventLoopGroup: eventLoopGroup)
        self.client = try MongoClient(settings: settings)
        self.database = self.client.db("your_database_name")
    }

    // Create operation
    func createDocument(document: Document) {
        let collection = self.database.collection("your_collection_name")

        do {
            try collection.insertOne(document)
            print("Document inserted successfully.")
        } catch {
            print("Failed to insert document: \(error)")
        }
    }

    // Read operation
    func readDocuments() {
        let collection = self.database.collection("your_collection_name")

        do {
            let documents = try collection.find()
            for document in documents {
                print(document)
            }
        } catch {
            print("Failed to read documents: \(error)")
        }
    }

    // Update operation
    func updateDocument(filter: Document, update: Document) {
        let collection = self.database.collection("your_collection_name")

        do {
            try collection.updateOne(filter: filter, update: update)
            print("Document updated successfully.")
        } catch {
            print("Failed to update document: \(error)")
        }
    }

    // Delete operation
    func deleteDocument(filter: Document) {
        let collection = self.database.collection("your_collection_name")

        do {
            try collection.deleteOne(filter)
            print("Document deleted successfully.")
        } catch {
            print("Failed to delete document: \(error)")
        }
    }

    // Close the MongoDB connection
    func closeConnection() {
        do {
            try self.client.syncClose().wait()
            print("MongoDB connection closed.")
        } catch {
            print("Failed to close MongoDB connection: \(error)")
        }
    }
}
```

## Step 5: Using the MongoDB Manager class in a View Controller:

```swift
import UIKit
import MongoSwift

class ViewController: UIViewController {
    var mongoDBManager: MongoDBManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            self.mongoDBManager = try MongoDBManager()
        } catch {
            print("Failed to initialize MongoDB Manager: \(error)")
        }
    }

    // Example usage of CRUD operations
    func performCRUDOperations() {
        // Create operation
        let document: Document = [
            "name": "John Doe",
            "age": 30,
            "email": "johndoe@example.com"
        ]
        self.mongoDBManager.createDocument(document: document)

        // Read operation
        self.mongoDBManager.readDocuments()

        // Update operation
        let filter: Document = ["name": "John Doe"]
        let update: Document = ["$set": ["age": 31]]
        self.mongoDBManager.updateDocument(filter: filter, update: update)

        // Delete operation
        self.mongoDBManager.deleteDocument(filter: filter)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mongoDBManager.closeConnection()
    }
}
```


