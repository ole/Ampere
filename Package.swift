// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ampere",
    platforms: [.macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(
            name: "Ampere",
            targets: ["Ampere"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Ampere",
            dependencies: []),
        .testTarget(
            name: "AmpereTests",
            dependencies: ["Ampere"]),
    ]
)
