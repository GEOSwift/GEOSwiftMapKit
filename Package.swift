// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "GEOSwiftMapKit",
  products: [
    .library(name: "GEOSwiftMapKit", targets: ["GEOSwiftMapKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/GEOSwift/GEOSwift.git", from: "6.0.0")
  ],
  targets: [
    .target(
      name: "GEOSwiftMapKit",
      dependencies: ["GEOSwift"],
      path: "./GEOSwiftMapKit/"
    ),
    .testTarget(
      name: "GEOSwiftMapKitTests",
      dependencies: ["GEOSwiftMapKit"],
      path: "./GEOSwiftMapKitTests/"
    )
  ]
)
