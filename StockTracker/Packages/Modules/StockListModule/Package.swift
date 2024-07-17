// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StockListModule",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "StockListModule",
            targets: ["StockListModule"]),
    ],
    dependencies: [
        .package(path: "../../Base"),
        .package(path: "../../Coordinator"),
        .package(path: "../../CommonView"),
        .package(path: "../../Entity"),
        .package(path: "../../GraphQLClient"),
        .package(path: "../../StockDetailModule"),
        .package(path: "../../UIExtension"),
    ],
    targets: [
        .target(
            name: "StockListModule", dependencies: 
                [
                    "Base",
                    "Coordinator",
                    "CommonView",
                    "GraphQLClient",
                    "Entity",
                    "StockDetailModule",
                    "UIExtension",
                ]),
        .testTarget(
            name: "StockListModuleTests",
            dependencies: ["StockListModule"]),
    ]
)
