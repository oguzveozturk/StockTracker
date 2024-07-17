// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIExtension",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UIExtension",
            targets: ["UIExtension"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hoangtaiki/Refreshable", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        .target(
            name: "UIExtension", dependencies: ["Refreshable", "Kingfisher"])
    ]
)
