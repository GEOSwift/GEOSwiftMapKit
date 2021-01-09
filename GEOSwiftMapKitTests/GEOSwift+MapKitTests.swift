import XCTest
import MapKit
import GEOSwift
import GEOSwiftMapKit

final class MapKitTests: XCTestCase {

    func testCreateCLLocationCoordinate2DFromPoint() {
        let point = Point(x: 45, y: 9)

        let coordinate = CLLocationCoordinate2D(point)

        XCTAssertEqual(coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }

    func testCreatePointWithLatAndLong() {
        let point = Point(longitude: 1, latitude: 2)

        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)
    }

    func testCreatePointWithCLLocationCoordinate2D() {
        let coord = CLLocationCoordinate2D(latitude: 2, longitude: 1)

        XCTAssertEqual(Point(coord), Point(x: 1, y: 2))
    }

    func testWorldPolygon() {
        // just make sure it doesn't crash
        _ = GEOSwift.Polygon.world
    }

    func testCreateMKCoordinateRegionContainingGeometry() {
        let lineString = try! LineString(wkt: "LINESTRING(3 4,10 50,20 25)")

        let region = try? MKCoordinateRegion(containing: lineString)

        XCTAssertEqual(region, MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 27, longitude: 11.5),
            span: MKCoordinateSpan(latitudeDelta: 46, longitudeDelta: 17)))
    }

    func testCreateMKPointAnnotationFromPoint() {
        let point = Point(x: 45, y: 9)

        let annotation = MKPointAnnotation(point: point)

        XCTAssertEqual(annotation.coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }

    func testCreateMKPlacemarkFromPoint() {
        let point = Point(x: 45, y: 9)

        let placemark = MKPlacemark(point: point)

        XCTAssertEqual(placemark.coordinate, CLLocationCoordinate2D(latitude: 9, longitude: 45))
    }

    func testCreateMKPolylineFromLineString() {
        let lineString = try! LineString(wkt: "LINESTRING(3 4,10 50,20 25)")

        let polyline = MKPolyline(lineString: lineString)

        XCTAssertEqual(polyline.pointCount, 3)
    }

    func testCreateMKPolygonFromLinearRing() {
        let linearRing = try! Polygon.LinearRing(
            points: [
                Point(x: 35, y: 10),
                Point(x: 45, y: 45),
                Point(x: 15, y: 40),
                Point(x: 10, y: 20),
                Point(x: 35, y: 10)])

        let mkPolygon = MKPolygon(linearRing: linearRing)

        XCTAssertEqual(mkPolygon.pointCount, 5)
        if #available(iOS 13.0, tvOS 13.0, macOS 10.15, *) {
            XCTAssertNil(mkPolygon.interiorPolygons)
        } else {
            XCTAssertEqual(mkPolygon.interiorPolygons?.count, 0)
        }
    }

    func testCreateMKPolygonFromPolygon() {
        let polygon = try! Polygon(
            wkt: "POLYGON((35 10, 45 45, 15 40, 10 20, 35 10),(20 30, 35 35, 30 20, 20 30))")

        let mkPolygon = MKPolygon(polygon: polygon)

        XCTAssertEqual(mkPolygon.pointCount, 5)
        XCTAssertEqual(mkPolygon.interiorPolygons?.count, 1)
        XCTAssertEqual(mkPolygon.interiorPolygons?.first?.pointCount, 4)
    }

    func testCreateMKMultiPolylineFromMultiLineString() {
        guard #available(iOS 13.0, tvOS 13.0, macOS 10.15, *) else {
            return
        }

        let multiLineString = try! MultiLineString(lineStrings: [
            LineString(points: [Point(x: 0, y: 0), Point(x: 0, y: 1)]),
            LineString(points: [Point(x: 0, y: 0), Point(x: 1, y: 0)])])

        let mkMultiPolyline = MKMultiPolyline(multiLineString: multiLineString)

        XCTAssertEqual(mkMultiPolyline.polylines.count, multiLineString.lineStrings.count)
    }

    func testCreateMKMultiPolygonFromMultiPolygon() {
        guard #available(iOS 13.0, tvOS 13.0, macOS 10.15, *) else {
            return
        }

        let multiPolygon = try! MultiPolygon(polygons: [
            Polygon(wkt: "POLYGON((35 10, 45 45, 15 40, 10 20, 35 10),(20 30, 35 35, 30 20, 20 30))"),
            Polygon(wkt: "POLYGON((35 10, 45 45, 15 40, 10 20, 35 10))")])

        let mkMultiPolygon = MKMultiPolygon(multiPolygon: multiPolygon)

        XCTAssertEqual(mkMultiPolygon.polygons.count, multiPolygon.polygons.count)
    }

    func testGeometryMapShape() {
        let polygon = try! Polygon(wkt: "POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))")

        let geometryMapShape = try! GeometryMapShape(geometry: polygon)

        let topLeft = MKMapPoint(CLLocationCoordinate2D(
            latitude: 2,
            longitude: 0))
        let bottomRight = MKMapPoint(CLLocationCoordinate2D(
            latitude: 0,
            longitude: 2))
        let boundingMapRect = MKMapRect(
            origin: topLeft,
            size: MKMapSize(
                width: bottomRight.x - topLeft.x,
                height: bottomRight.y - topLeft.y))
        XCTAssertEqual(geometryMapShape.boundingMapRect, boundingMapRect)
        XCTAssertEqual(geometryMapShape.geometry.geometry, polygon.geometry)
        XCTAssertEqual(geometryMapShape.coordinate, CLLocationCoordinate2D(latitude: 1, longitude: 1))
    }

    // Test case for Issue #134
    // https://github.com/GEOSwift/GEOSwift/issues/134
    func testGeometryMapShapeHasBoundingMapRectWithPositiveWidthAndHeight() {
        let lineString = try! LineString(points: [Point(x: -1, y: 1), Point(x: 1, y: -1)])
        let geometryCollection = GeometryCollection(geometries: [lineString])
        let geometryMapShape = try! GeometryMapShape(geometry: geometryCollection)

        let boundingMapRect = geometryMapShape.boundingMapRect

        XCTAssertGreaterThan(boundingMapRect.height, 0)
        XCTAssertGreaterThan(boundingMapRect.width, 0)
    }
}
