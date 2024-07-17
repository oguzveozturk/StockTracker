// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GraphQLClient",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GraphQLClient",
            targets: ["GraphQLClient"]),
    ],
    dependencies: [
        .package(path: "../ApolloModels"),
        .package(path: "../Entity"),
        .package(path: "../Extension"),
        .package(
            url: "https://github.com/joel-perry/ApolloCombine",
            .upToNextMajor(from: "0.8.0")
        ),
    ],
    targets: [
        .target(
            name: "GraphQLClient", 
            dependencies: [
                "ApolloCombine",
                "ApolloModels",
                "Entity",
                "Extension",
            ]
        )
    ]
)
