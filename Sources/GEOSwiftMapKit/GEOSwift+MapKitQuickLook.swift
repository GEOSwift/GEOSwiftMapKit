#if os(iOS)

import UIKit
import MapKit
import GEOSwift

protocol GEOSwiftQuickLook: CustomPlaygroundDisplayConvertible, GeometryConvertible {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect)
}

extension GEOSwiftQuickLook {
    public var playgroundDescription: Any {
        let defaultReturnValue: Any = (try? geometry.wkt()) ?? self
        guard let buffered = try? geometry.buffer(by: 0.1).intersection(with: Polygon.world),
            let region = try? MKCoordinateRegion(containing: buffered) else {
                return defaultReturnValue
        }
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        mapView.region = region
        guard let image = mapView.snapshot else {
            return defaultReturnValue
        }
        UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return defaultReturnValue
        }
        defer { UIGraphicsEndImageContext() }
        image.draw(at: .zero)
        quickLookDraw(in: context, imageSize: image.size, mapRect: mapView.visibleMapRect)
        return UIGraphicsGetImageFromCurrentImageContext() ?? defaultReturnValue
    }

    fileprivate func draw(
        in context: CGContext,
        imageSize: CGSize,
        mapRect: MKMapRect,
        renderer: MKOverlayRenderer) {
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
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: "")
        if let pinImage = pin.image {
            let coord = CLLocationCoordinate2D(self)
            let mapPoint = MKMapPoint(coord)
            let point = CGPoint(
                x: round(CGFloat((mapPoint.x - mapRect.origin.x) / mapRect.size.width) * imageSize.width),
                y: round(CGFloat((mapPoint.y - mapRect.origin.y) / mapRect.size.height) * imageSize.height))
            var pinImageRect = CGRect(x: 0, y: 0, width: pinImage.size.width, height: pinImage.size.height)
            pinImageRect = pinImageRect.offsetBy(dx: point.x - pinImageRect.width / 2,
                                                 dy: point.y - pinImageRect.height)
            pinImage.draw(in: pinImageRect)
        }
    }
}

extension MultiPoint: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        for point in points {
            point.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        }
    }
}

extension LineString: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        let polyline = MKPolyline(lineString: self)
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.lineWidth = 2
        renderer.strokeColor = UIColor.blue.withAlphaComponent(0.7)
        draw(in: context, imageSize: imageSize, mapRect: mapRect, renderer: renderer)
    }
}

extension MultiLineString: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        for lineString in lineStrings {
            lineString.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        }
    }
}

extension GEOSwift.Polygon.LinearRing: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        lineString.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
    }
}

extension GEOSwift.Polygon: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        let polygon = MKPolygon(polygon: self)
        let renderer = MKPolygonRenderer(overlay: polygon)
        renderer.lineWidth = 2
        renderer.strokeColor = UIColor.blue.withAlphaComponent(0.7)
        renderer.fillColor = UIColor.cyan.withAlphaComponent(0.2)
        draw(in: context, imageSize: imageSize, mapRect: mapRect, renderer: renderer)
    }
}

extension MultiPolygon: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        for polygon in polygons {
            polygon.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        }
    }
}

extension GeometryCollection: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        for geometry in geometries {
            geometry.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        }
    }
}

extension Geometry: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        switch self {
        case let .point(point):
            point.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .multiPoint(multiPoint):
            multiPoint.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .lineString(lineString):
            lineString.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .multiLineString(multiLineString):
            multiLineString.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .polygon(polygon):
            polygon.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .multiPolygon(multiPolygon):
            multiPolygon.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        case let .geometryCollection(geometryCollection):
            geometryCollection.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
        }
    }
}

extension Envelope: GEOSwiftQuickLook {
    func quickLookDraw(in context: CGContext, imageSize: CGSize, mapRect: MKMapRect) {
        geometry.quickLookDraw(in: context, imageSize: imageSize, mapRect: mapRect)
    }
}

// MARK: - MKMapView Snapshotting
private extension MKMapView {
    /**
     Take a snapshot of the map with MKMapSnapshot, which is designed to work in the background,
     so we block the calling thread with a semaphore.
     */
    var snapshot: UIImage? {
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = frame.size
        var snapshotImage: UIImage?
        let backgroundQueue = DispatchQueue.global(qos: .background)
        let snapshotter = MKMapSnapshotter(options: options)
        let semaphore = DispatchSemaphore(value: 0)
        snapshotter.start(with: backgroundQueue) { snapshot, _ in
            snapshotImage = snapshot?.image
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 3)
        return snapshotImage
    }
}

#endif
