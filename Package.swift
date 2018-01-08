// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BashArrow",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vknabel/ArrowKit.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "BashArrow",
            dependencies: ["ArrowKit"]
        ),
    ]
)
