// Exclude these tests when running in Swift PM because it doesn't support bundle resources yet
#if !SWIFT_PACKAGE && os(iOS)

import XCTest
import MapKit
import GEOSwift
@testable import GEOSwiftMapKit

final class QuickLookTests: XCTestCase {
    let point = Point(
        longitude: 0.5,
        latitude: 0.5)
    let multiPoint = MultiPoint(points: [
        Point(x: -1, y: -1),
        Point(x: 1, y: 1)])
    let lineString = try! LineString(points: [
        Point(x: -1, y: -1),
        Point(x: 1, y: 1)])
    let linearRing = try! Polygon.LinearRing(
        points: [
            Point(x: 1, y: 1),
            Point(x: 0, y: 1),
            Point(x: 0, y: 0),
            Point(x: 1, y: 0),
            Point(x: 1, y: 1)])
    var multiLineString: MultiLineString!
    var polygon: Polygon!
    let otherPolygon = try! Polygon(
        exterior: Polygon.LinearRing(
            points: [
                Point(x: 0, y: 0),
                Point(x: -1, y: 0),
                Point(x: 0, y: -1),
                Point(x: 0, y: 0)]),
        holes: [
            Polygon.LinearRing(
                points: [
                    Point(x: -0.2, y: -0.2),
                    Point(x: -0.6, y: -0.2),
                    Point(x: -0.2, y: -0.6),
                    Point(x: -0.2, y: -0.2)])])
    var multiPolygon: MultiPolygon!
    var geometryCollection: GeometryCollection!
    let imageSize = CGSize(width: 400, height: 400)
    var context: CGContext!

    override func setUp() {
        super.setUp()
        polygon = Polygon(exterior: linearRing)
        multiLineString = MultiLineString(
            lineStrings: [lineString, linearRing.lineString])
        multiPolygon = MultiPolygon(polygons: [polygon, otherPolygon])
        geometryCollection = GeometryCollection(
            geometries: [
                point,
                multiPoint,
                lineString,
                linearRing,
                multiLineString,
                polygon,
                otherPolygon,
                multiPolygon])
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 1)
        context = UIGraphicsGetCurrentContext()
    }

    override func tearDown() {
        if context != nil {
            UIGraphicsEndImageContext()
            context = nil
        }
        geometryCollection = nil
        multiPolygon = nil
        polygon = nil
        multiLineString = nil
        super.tearDown()
    }

    func testDrawPoint() {
        verifyDrawing(with: point, expected: .point)
    }

    func testDrawMultiPoint() {
        verifyDrawing(with: multiPoint, expected: .multiPoint)
    }

    func testDrawLineString() {
        verifyDrawing(with: lineString, expected: .lineString)
    }

    func testDrawLinearRing() {
        verifyDrawing(with: linearRing, expected: .linearRing)
    }

    func testDrawMultiLineString() {
        verifyDrawing(with: multiLineString, expected: .multiLineString)
    }

    func testDrawPolygon() {
        verifyDrawing(with: polygon, expected: .polygon)
    }

    func testDrawMultiPolygon() {
        verifyDrawing(with: multiPolygon, expected: .multiPolygon)
    }

    func testDrawGeometryCollection() {
        verifyDrawing(with: geometryCollection, expected: .geometryCollection)
    }

    func testDrawGeometryCollectionViaGeometry() {
        verifyDrawing(with: Geometry.geometryCollection(geometryCollection), expected: .geometryCollection)
    }

    func testDrawEnvelope() {
        verifyDrawing(with: try! geometryCollection.envelope(), expected: .envelope)
    }

    // MARK: - Helpers

    /// SnapshotImages are from iPhone XS, so use that simulator when running unit tests
    func verifyDrawing(with geometry: GEOSwiftQuickLook,
                       expected: SnapshotImage,
                       line: UInt = #line) {
        guard let context = context else {
            XCTFail("Unable to create graphics context", line: line)
            return
        }
        let mapRectCenter = MKMapPoint(CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let width = MKMapPointsPerMeterAtLatitude(0) * 300000
        let mapRect = MKMapRect(
            origin: MKMapPoint(x: mapRectCenter.x - width / 2, y: mapRectCenter.y - width / 2),
            size: MKMapSize(width: width, height: width))

        geometry.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            XCTFail("Unable to get image", line: line)
            return
        }
        XCTAssertEqual(image.pngData(), expected.data, line: line)
        if expected.data == nil {
            savePNG(with: image, name: expected.name)
        }
    }

    // Use this method to generate new reference PNGs when adding rendering tests.
    // It prints the URL where it saved the image so you can find it and add it to the project.
    // It makes heavy use of force-unwrapping because this should only be used during development.
    func savePNG(with image: UIImage, name: String) {
        let png = image.pngData()!
        let urls = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)
        let url = urls.first!.appendingPathComponent(name)
        do {
            try png.write(to: url)
            print("Saved PNG to: \(url)")
        } catch {
            print("Could not save PNG because: \(error)")
        }
    }
}

#endif
