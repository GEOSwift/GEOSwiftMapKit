// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "GEOSwiftMapKit",
    platforms: [.iOS(.v9), .macOS("10.9"), .tvOS("9.2")],
    products: [
        .library(name: "GEOSwiftMapKit", targets: ["GEOSwiftMapKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/GEOSwift/GEOSwift.git", from: "8.0.1")
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
