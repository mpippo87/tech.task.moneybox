// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "MBFoundation",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MBFoundation",
            targets: ["MBFoundation"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MBFoundation",
            dependencies: []
        ),
        .testTarget(
            name: "MBFoundationTests",
            dependencies: ["MBFoundation"]
        )
    ]
)
