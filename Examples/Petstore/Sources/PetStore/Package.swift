// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "PetStore",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "PetStore",
            targets: ["PetStore"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PetStore",
            dependencies: []
        )
    ]
)
