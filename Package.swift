// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC",
    products: [
      .library(name: "AOC", targets: ["AOC"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Quick/Quick.git", from: "1.0.0"),
      .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "AOC",
            dependencies: []),
        .testTarget(
          name: "AOCTests",
          dependencies: ["Quick", "Nimble", "AOC"]
        ),
    ]
)
