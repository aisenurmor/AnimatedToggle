// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnimatedToggle",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AnimatedToggle",
            targets: ["AnimatedToggle"]
        ),
    ],
    targets: [
        .target(
            name: "AnimatedToggle"
        )
    ]
)
