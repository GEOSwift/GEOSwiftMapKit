#if os(iOS) || os(tvOS)
import UIKit
import MapKit
import GEOSwift

#if compiler(>=6)
extension Point: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiPoint: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension LineString: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiLineString: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GEOSwift.Polygon.LinearRing: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GEOSwift.Polygon: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiPolygon: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GeometryCollection: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension Geometry: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension Envelope: @retroactive CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}
#else
extension Point: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiPoint: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension LineString: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiLineString: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GEOSwift.Polygon.LinearRing: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GEOSwift.Polygon: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension MultiPolygon: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension GeometryCollection: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension Geometry: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}

extension Envelope: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any { makePlaygroundDescription(for: self) }
}
#endif

private func makePlaygroundDescription(for g: (some GEOSwiftQuickLook)) -> Any {
    let defaultReturnValue: Any = (try? g.geometry.wkt()) ?? g
    var bufferValue: Double = 0
    if case .point = g.geometry {
        bufferValue = 0.1
    }
    guard let buffered = try? g.geometry.buffer(by: bufferValue)?.intersection(with: Polygon.world),
          let region = try? MKCoordinateRegion(containing: buffered) else {
        return defaultReturnValue
    }

    let options = MKMapSnapshotter.Options()
    options.region = region
    options.size = CGSize(width: 400, height: 400)
    var snapshot: MKMapSnapshotter.Snapshot?
    let backgroundQueue = DispatchQueue.global(qos: .userInitiated)
    let snapshotter = MKMapSnapshotter(options: options)
    let semaphore = DispatchSemaphore(value: 0)
    snapshotter.start(with: backgroundQueue) { s, _ in
        snapshot = s
        semaphore.signal()
    }
    _ = semaphore.wait(timeout: .now() + 3)
    guard let snapshot else {
        return defaultReturnValue
    }
    let format = UIGraphicsImageRendererFormat.preferred()
    format.opaque = true
    format.scale = snapshot.image.scale
    return UIGraphicsImageRenderer(size: snapshot.image.size, format: format).image { context in
        snapshot.image.draw(at: .zero)
        g.quickLookDraw(in: context.cgContext, snapshot: snapshot)
    }
}

private protocol GEOSwiftQuickLook: GeometryConvertible {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot)
}

private extension GEOSwiftQuickLook {
    func draw(
        in context: CGContext,
        imageSize: CGSize,
        mapRect: MKMapRect,
        renderer: MKOverlayRenderer
    ) {
        context.saveGState()

        // scale the content to fit inside the image
        let scaleX = imageSize.width / CGFloat(mapRect.size.width)
        let scaleY = imageSize.height / CGFloat(mapRect.size.height)
        context.scaleBy(x: scaleX, y: scaleY)

        // the renderer will draw the geometry at (0,0), so offset CoreGraphics by the right measure
        let upperCorner = renderer.mapPoint(for: .zero)
        context.translateBy(x: CGFloat(upperCorner.x - mapRect.origin.x),
                            y: CGFloat(upperCorner.y - mapRect.origin.y))

        renderer.draw(mapRect, zoomScale: imageSize.width / CGFloat(mapRect.size.width), in: context)

        context.restoreGState()
    }
}

extension Point: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        let coord = CLLocationCoordinate2D(self)
        let point = snapshot.point(for: coord)
        let rect = CGRect(origin: point, size: .zero).insetBy(dx: -10, dy: -10)
        UIColor.red.setFill()
        context.fillEllipse(in: rect)
    }
}

extension MultiPoint: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        for point in points {
            point.quickLookDraw(in: context, snapshot: snapshot)
        }
    }
}

extension LineString: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        UIColor.blue.withAlphaComponent(0.7).setStroke()
        let path = UIBezierPath()
        path.move(to: snapshot.point(for: CLLocationCoordinate2D(firstPoint)))
        for point in points[1...] {
            path.addLine(to: snapshot.point(for: CLLocationCoordinate2D(point)))
        }
        path.lineWidth = 2
        path.stroke()
    }
}

extension MultiLineString: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        for lineString in lineStrings {
            lineString.quickLookDraw(in: context, snapshot: snapshot)
        }
    }
}

extension GEOSwift.Polygon.LinearRing: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        lineString.quickLookDraw(in: context, snapshot: snapshot)
    }
}

extension GEOSwift.Polygon: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        UIColor.blue.withAlphaComponent(0.7).setStroke()
        UIColor.cyan.withAlphaComponent(0.2).setFill()
        let path = UIBezierPath()
        path.move(to: snapshot.point(for: CLLocationCoordinate2D(exterior.points.first!)))
        for point in exterior.points[1...] {
            path.addLine(to: snapshot.point(for: CLLocationCoordinate2D(point)))
        }
        path.close()
        for hole in holes {
            path.move(to: snapshot.point(for: CLLocationCoordinate2D(hole.points.first!)))
            for point in hole.points[1...] {
                path.addLine(to: snapshot.point(for: CLLocationCoordinate2D(point)))
            }
            path.close()
        }
        path.lineWidth = 2
        path.fill()
        path.stroke()
    }
}

extension MultiPolygon: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        for polygon in polygons {
            polygon.quickLookDraw(in: context, snapshot: snapshot)
        }
    }
}

extension GeometryCollection: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        for geometry in geometries {
            geometry.quickLookDraw(in: context, snapshot: snapshot)
        }
    }
}

extension Geometry: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        switch self {
        case let .point(point):
            point.quickLookDraw(in: context, snapshot: snapshot)
        case let .multiPoint(multiPoint):
            multiPoint.quickLookDraw(in: context, snapshot: snapshot)
        case let .lineString(lineString):
            lineString.quickLookDraw(in: context, snapshot: snapshot)
        case let .multiLineString(multiLineString):
            multiLineString.quickLookDraw(in: context, snapshot: snapshot)
        case let .polygon(polygon):
            polygon.quickLookDraw(in: context, snapshot: snapshot)
        case let .multiPolygon(multiPolygon):
            multiPolygon.quickLookDraw(in: context, snapshot: snapshot)
        case let .geometryCollection(geometryCollection):
            geometryCollection.quickLookDraw(in: context, snapshot: snapshot)
        }
    }
}

extension Envelope: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, snapshot: MKMapSnapshotter.Snapshot) {
        geometry.quickLookDraw(in: context, snapshot: snapshot)
    }
}

#endif
