// swift-tools-version:5.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "BashArrow",
    products: [
        .executable(name: "BashArrow", targets: ["BashArrow"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vknabel/ArrowKit.git", from: "0.2.3"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.2"),
    ],
    targets: [
        .target(name: "BashArrow", dependencies: ["BashArrowKit"]),
        .target(name: "BashArrowKit", dependencies: ["ArrowKit", "SwiftCLI"]),
        .testTarget(name: "BashArrowKitTests", dependencies: ["BashArrowKit", "SwiftCLI"]),
    ]
)
