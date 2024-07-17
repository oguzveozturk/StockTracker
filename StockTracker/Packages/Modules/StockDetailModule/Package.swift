// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StockDetailModule",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "StockDetailModule",
            targets: ["StockDetailModule"]),
    ],
    dependencies: [
        .package(path: "../../Base"),
        .package(path: "../../CommonView"),
        .package(path: "../../Coordinator"),
        .package(path: "../../Entity"),
        .package(path: "../../Extension"),
        .package(path: "../../GraphQLClient"),
        .package(path: "../../STChart"),
        .package(path: "../../UIExtension"),
    ],
    targets: [
        .target(
            name: "StockDetailModule", dependencies:
                [
                    "Base",
                    "CommonView",
                    "Coordinator",
                    "GraphQLClient",
                    "Entity",
                    "Extension",
                    "STChart",
                    "UIExtension",
                ]),
        .testTarget(
            name: "StockDetailModuleTests",
            dependencies: ["StockDetailModule"]),
    ]
)
