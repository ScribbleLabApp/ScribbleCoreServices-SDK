// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScribbleCoreServices",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ScribbleCoreServices",
            targets: ["ScribbleCoreServices"]),
        .library(name: "ScribbleCoreServicesObjc", targets: ["ScribbleCoreServicesObjc"])
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ScribbleCoreServices",
            dependencies: [],
            path: "Sources/ScribbleCoreServices",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("Sources/ScribbleCoreServices/ScribbleCoreServices.h"),
            ]),
        .target(
            name: "ScribbleCoreServicesObjc",
            dependencies: [],
            path: "Sources/ScribbleCoreServicesObjc",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "ScribbleCoreServicesTest",
            dependencies: [
                "ScribbleCoreServices"
            ],
            path: "Sources/Tests/ScribbleCoreServicesTests"),
    ]
)
