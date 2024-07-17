// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApolloModels",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ApolloModels",
            targets: ["ApolloModels"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apollographql/apollo-ios.git",
            .upToNextMajor(from: "1.0.0")
        ),
    ],
    targets: [
        .target(
            name: "ApolloModels", dependencies: [.product(name: "Apollo", package: "apollo-ios")])
    ]
)
