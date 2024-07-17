// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ModelGenerator",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .executable(name: "ApolloCodegen", targets: ["ApolloCodegen"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios-codegen.git",
             .upToNextMajor(from: "1.0.0")),
    .package(url: "https://github.com/apple/swift-argument-parser.git",
             .upToNextMajor(from: "1.3.0")),
  ],
  targets: [
    .executableTarget(
      name: "ApolloCodegen",
      dependencies: [
        .product(name: "ApolloCodegenLib", package: "apollo-ios-codegen"),
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]),
  ]
)
