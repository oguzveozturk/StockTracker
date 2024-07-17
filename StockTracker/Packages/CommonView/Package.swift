// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonView",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CommonView",
            targets: ["CommonView"]),
    ],
    dependencies: [
        .package(path: "../../Base"),
        .package(path: "../../Extension"),
        .package(path: "../../UIExtension"),

    ],
    targets: [
        .target(
            name: "CommonView", dependencies: [
                "Base",
                "Extension",
                "UIExtension"
            ]),
    ]
)
