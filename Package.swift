// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenLCB",
    products: [
        .library(
            name: "OpenLCB",
            targets: ["OpenLCB"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "OpenLCB",
            dependencies: []),
        .testTarget(
            name: "OpenLCBTests",
            dependencies: ["OpenLCB"])
    ]
)
