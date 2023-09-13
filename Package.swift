// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NosyInspect",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NosyInspect",
            targets: ["NosyInspect"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.19.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NosyInspect",
            dependencies: [
                .product(name: "GRPC", package: "grpc-swift")
            ]
        ),
        .testTarget(
            name: "NosyInspectTests",
            dependencies: ["NosyInspect"]
        ),
    ]
)
