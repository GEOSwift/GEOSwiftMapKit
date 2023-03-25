// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "GEOSwiftMapKit",
    platforms: [.iOS(.v9), .macOS("10.9"), .tvOS("9.2")],
    products: [
        .library(name: "GEOSwiftMapKit", targets: ["GEOSwiftMapKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/GEOSwift/GEOSwift.git", from: "10.0.0")
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
