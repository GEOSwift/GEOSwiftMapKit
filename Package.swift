// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GEOSwiftMapKit",
    platforms: [.iOS(.v12), .macOS(.v10_13), .tvOS(.v12)],
    products: [
        .library(name: "GEOSwiftMapKit", targets: ["GEOSwiftMapKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/GEOSwift/GEOSwift.git", from: "11.0.0")
    ],
    targets: [
        .target(
            name: "GEOSwiftMapKit",
            dependencies: ["GEOSwift"]
        ),
        .testTarget(
            name: "GEOSwiftMapKitTests",
            dependencies: ["GEOSwiftMapKit"]
        )
    ]
)
