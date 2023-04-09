[Origin](https://augmentedcode.io/2022/11/28/setting-up-a-build-tool-plugin-for-a-swift-package/)

# Setting up a build tool plugin for a Swift package
## Introduction
Writing a Swift Package Build Tool Plugin which takes in a JSON and outputs some Swift code which in turn is used by the package.

## Package.swift
```swift
// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "ToomasKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ToomasKit",
            targets: ["ToomasKit"]
        ),
    ],
    targets: [
        .target(
            name: "ToomasKit",
            plugins: [
                .plugin(name: "ToomasKitPlugin")
            ]
        ),
        .executableTarget(
            name: "CodeGenerator"
        ),
        .plugin(
            name: "ToomasKitPlugin",
            capability: .buildTool(),
            dependencies: ["CodeGenerator"]
        ),
        .testTarget(
            name: "ToomasKitTests",
            dependencies: ["ToomasKit"]
        ),
    ]
)
``` 

## Plugin
```swift
import Foundation
import PackagePlugin

@main
struct ToomasKitPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        let inputJSON = target.directory.appending("Source.json")
        let output = context.pluginWorkDirectory.appending("GeneratedEnum.swift")
        return [
            .buildCommand(displayName: "Generate Code",
                          executable: try context.tool(named: "CodeGenerator").path,
                          arguments: [inputJSON, output],
                          environment: [:],
                          inputFiles: [inputJSON],
                          outputFiles: [output])
        ]
    }
}
```

## Executable
* Parse two command line parameters (can use Swift-Command-Parser instead)
    - URL of input JSON file
    - URL of output source code which are included to package build


```swift
@main
@available(macOS 13.0.0, *)
struct CodeGenerator {
    static func main() async throws {
        // Use swift-argument-parser or just CommandLine, here we just imply that 2 paths are passed in: input and output
        guard CommandLine.arguments.count == 3 else {
            throw CodeGeneratorError.invalidArguments
        }
        // arguments[0] is the path to this command line tool
        let input = URL(filePath: CommandLine.arguments[1])
        let output = URL(filePath: CommandLine.arguments[2])
        
        let jsonData = try Data(contentsOf: input)
        let enumFormat = try JSONDecoder().decode(JSONFormat.self, from: jsonData)
        
        let code = """
        enum \(enumFormat.name): CaseIterable {
        \t\(enumFormat.cases.map({ "case \($0)" }).joined(separator: "\n\t"))
        }
        """
        guard let data = code.data(using: .utf8) else {
            throw CodeGeneratorError.invalidData
        }
        try data.write(to: output, options: .atomic)
    }
}

struct JSONFormat: Decodable {
    let name: String
    let cases: [String]
}

@available(macOS 13.00.0, *)
enum CodeGeneratorError: Error {
    case invalidArguments
    case invalidData
}
``` 

