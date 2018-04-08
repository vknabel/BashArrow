// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "BashArrow",
    dependencies: [
        .package(url: "https://github.com/vknabel/ArrowKit.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "BashArrow",
            dependencies: ["BashArrowKit"]
        ),
        .target(
            name: "BashArrowKit",
            dependencies: ["ArrowKit"]
        ),
        .testTarget(
            name: "BashArrowKitTests",
            dependencies: ["BashArrowKit"]
        ),
    ]
)
