import Foundation

enum SnapshotImage: String {
    case point
    case multiPoint = "multipoint"
    case lineString = "linestring"
    case linearRing = "linearring"
    case multiLineString = "multilinestring"
    case polygon
    case multiPolygon = "multipolygon"
    case geometryCollection = "geometrycollection"
    case envelope

    var name: String {
        return rawValue + ".png"
    }

    var data: Data? {
        guard let url = Bundle(for: BundleLocator.self)
            .url(forResource: rawValue, withExtension: "png") else {
                return nil
        }
        return try? Data(contentsOf: url)
    }
}

private class BundleLocator {}
