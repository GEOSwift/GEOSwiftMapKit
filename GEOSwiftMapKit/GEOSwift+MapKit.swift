import GEOSwift
import MapKit

public extension CLLocationCoordinate2D {
    init(_ point: Point) {
        self.init(latitude: point.y, longitude: point.x)
    }
}

public extension Point {
    init(longitude: Double, latitude: Double) {
        self.init(x: longitude, y: latitude)
    }

    init(_ coordinate: CLLocationCoordinate2D) {
        self.init(x: coordinate.longitude, y: coordinate.latitude)
    }
}

public extension GEOSwift.Polygon {
    static var world: GEOSwift.Polygon {
        // swiftlint:disable:next force_try
        return try! Polygon(exterior: Polygon.LinearRing(points: [
            Point(x: -180, y: 90),
            Point(x: -180, y: -90),
            Point(x: 180, y: -90),
            Point(x: 180, y: 90),
            Point(x: -180, y: 90)]))
    }
}

// Note that this does not currently do a good job of supporting geometries that cross the anti-meridian
public extension MKCoordinateRegion {
    init(containing geometry: GeometryConvertible) throws {
        let envelope = try geometry.geometry.envelope()
        let center = try CLLocationCoordinate2D(envelope.geometry.centroid())
        let span = MKCoordinateSpan(
            latitudeDelta: envelope.maxY - envelope.minY,
            longitudeDelta: envelope.maxX - envelope.minX)
        self.init(center: center, span: span)
    }
}

public extension MKPointAnnotation {
    convenience init(point: Point) {
        self.init()
        coordinate = CLLocationCoordinate2D(point)
    }
}

public extension MKPlacemark {
    convenience init(point: Point) {
        self.init(coordinate: CLLocationCoordinate2D(point), addressDictionary: nil)
    }
}

public extension MKPolyline {
    convenience init(lineString: LineString) {
        var coordinates = lineString.points.map(CLLocationCoordinate2D.init)
        self.init(coordinates: &coordinates, count: coordinates.count)
    }
}

public extension MKPolygon {
    convenience init(linearRing: GEOSwift.Polygon.LinearRing) {
        var coordinates = linearRing.points.map(CLLocationCoordinate2D.init)
        self.init(coordinates: &coordinates, count: coordinates.count)
    }

    convenience init(polygon: GEOSwift.Polygon) {
        var exteriorCoordinates = polygon.exterior.points.map(CLLocationCoordinate2D.init)
        self.init(
            coordinates: &exteriorCoordinates,
            count: exteriorCoordinates.count,
            interiorPolygons: polygon.holes.map(MKPolygon.init))
    }
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
public extension MKMultiPolyline {
    convenience init(multiLineString: MultiLineString) {
        self.init(multiLineString.lineStrings.map(MKPolyline.init))
    }
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
public extension MKMultiPolygon {
    convenience init(multiPolygon: MultiPolygon) {
        self.init(multiPolygon.polygons.map(MKPolygon.init))
    }
}

// Note that this does not currently do a good job of supporting geometries that cross the anti-meridian
open class GeometryMapShape: MKShape, MKOverlay {
    public let geometry: GeometryConvertible

    private let _coordinate: CLLocationCoordinate2D
    override open var coordinate: CLLocationCoordinate2D {
        return _coordinate
    }

    public let boundingMapRect: MKMapRect

    public init(geometry: GeometryConvertible) throws {
        self.geometry = geometry
        self._coordinate = try CLLocationCoordinate2D(geometry.centroid())
        let envelope = try geometry.envelope()
        let topLeft = MKMapPoint(CLLocationCoordinate2D(envelope.minXMaxY))
        let bottomRight = MKMapPoint(CLLocationCoordinate2D(envelope.maxXMinY))
        self.boundingMapRect = MKMapRect(
            origin: topLeft,
            size: MKMapSize(
                width: bottomRight.x - topLeft.x,
                height: bottomRight.y - topLeft.y))
    }
}
