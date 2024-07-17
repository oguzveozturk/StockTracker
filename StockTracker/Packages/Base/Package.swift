// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Base",
    platforms: [.iOS(.v13)],
    products: [.library(name: "Base", targets: ["Base"])],
    targets: [.target(name: "Base")]
)
