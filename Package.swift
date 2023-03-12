// swift-tools-version:5.5
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
            path: "./GEOSwiftMapKitTests/",
            resources: [
                .copy("Snapshot Images/envelope.png"),
                .copy("Snapshot Images/geometrycollection.png"),
                .copy("Snapshot Images/linearring.png"),
                .copy("Snapshot Images/linestring.png"),
                .copy("Snapshot Images/multilinestring.png"),
                .copy("Snapshot Images/multipoint.png"),
                .copy("Snapshot Images/multipolygon.png"),
                .copy("Snapshot Images/point.png"),
                .copy("Snapshot Images/polygon.png"),
            ]
        )
    ]
)
