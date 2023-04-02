import UIKit
import GEOSwift
import GEOSwiftMapKit
import MapKit

try! Point(wkt: "POINT(10 45)")
//: # GEOSwift
//: _The Swift Geometry Engine_
//:
//: Easily handle geometric objects (points, linestrings, polygons etc.)
//: and the main related topographical operations (intersections,
//: overlapping etc.). GEOSwift is a MIT-licensed Swift interface to the
//: OSGeo's GEOS library routines*, plus some convenience features such as:
//:
//: * A pure-Swift, type-safe, optional-aware programming interface
//: * Automatically-typed geometry deserialization from WKT and WKB
//: representations
//: * MapKit and MapboxGL integration
//: * Quicklook integration
//: * GEOJSON support via Codable
//: * Equatable & Hashable support
//: * Thread-safe
//: * Robust error handling
//: * Extensively tested
//:
//: ## Handle a geometric data model
//:
//: GEOSwift lets you easily create geometry objects for all the geometry
//: types supported by GEOS:
//:
//: * Point
//: * LineString
//: * Polygon
//: * MultiPoint
//: * MultiLineString
//: * MultiPolygon
//: * GeometryCollection
//:
//: Geometries can be deserialized from and serialized back to their Well
//: Known Text (WKT) or Well Known Binary (WKB) representations.
// Create a POINT from its WKT representation.
let point = try! Point(wkt: "POINT(10 45)")

// Create a POLYGON from its WKT representation. Here: the Notre Dame cathedral building footprint
let polygon = try! Polygon(wkt: "POLYGON ((2.349252343714653 48.85347829980472, 2.3489192520770246 48.853050271993254, 2.35034958675422 48.852599033892346, 2.350565116637 48.852593876862244, 2.3507845652447372 48.852712488426135, 2.3508237524963533 48.852874934242834, 2.350682678390797 48.85304253651725, 2.349252343714653 48.85347829980472))")

// If the expected type is unknown, you can use Geometry(wkt:) and the
// returned value will be one of the Geometry enum cases
let geometry1 = try! Geometry(wkt: "POLYGON((35 10, 45 45.5, 15 40, 10 20, 35 10),(20 30, 35 35, 30 20, 20 30))")

// The same geometry can be represented in binary form as WKB
guard let wkbURL = Bundle.main.url(forResource: "example", withExtension: "wkb"),
    let wkbData = try? Data(contentsOf: wkbURL) else {
        exit(1)
}
let geometry2 = try! Geometry(wkb: wkbData)

if geometry1 == geometry2 && geometry1 != .point(point) {
    print("The two geometries are equal!")
}

// Examples of valid WKT geometries representations are:
// POINT(6 10)
// LINESTRING(35 10, 45 45, 15 40, 10 20, 35 10)
// LINESTRING(3 4,10 50,20 25)
// POLYGON((1 1,5 1,5 5,1 5,1 1),(2 2, 3 2, 3 3, 2 3,2 2))
// MULTIPOINT(3.5 5.6,4.8 10.5)
// MULTILINESTRING((3 4,10 50,20 25),(-5 -8,-10 -8,-15 -4))
// MULTIPOLYGON(((1 1,5 1,5 5,1 5,1 1),(2 2, 3 2, 3 3, 2 3,2 2)),((3 3,6 2,6 4,3 3)))
// GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))
//: ## MapKit Integration
//:
//: Convert the geometries to annotations and overlays, ready to be added
//: to a MKMapView
let shape1 = MKPointAnnotation(point: point)
let shape2 = try! GeometryMapShape(geometry: geometry1)
let annotations = [shape1, shape2]
//: ## Quicklook integration
//:
//: GEOSwiftMapKit adds QuickLook support to GEOSwift types! This means that
//: while debugging you can inspect complex geometries and see what they
//: represent: just stop on the variable with the mouse cursor or select
//: the geometry and press space in the debug area to see a preview. In
//: playgrounds you can display them just as any other object, like this:
geometry2
//: ### GEOJSON parsing
//:
//: Your geometries can be loaded from GEOJSON using JSONDecoder:
let jsonDecoder = JSONDecoder()
if let geoJSONURL = Bundle.main.url(forResource: "multipolygon", withExtension: "geojson"),
    let data = try? Data(contentsOf: geoJSONURL),
    let featureCollection = try? jsonDecoder.decode(FeatureCollection.self, from: data),
    case let .multiPolygon(italy)? = featureCollection.features.first?.geometry {

    italy
//: ### Topological operations:
    try! italy.buffer(by: 1)
    try! italy.boundary()
    try! italy.centroid()
    try! italy.convexHull()
    try! italy.envelope()
    try! italy.envelope().geometry.difference(with: italy)
    try! italy.pointOnSurface()
    try! italy.intersection(with: geometry2)
    try! italy.difference(with: geometry2)
    try! italy.union(with: geometry2)
//: ### Predicates:
    try! italy.isDisjoint(with: geometry2)
    try! italy.touches(geometry2)
    try! italy.intersects(geometry2)
    try! italy.crosses(geometry2)
    try! italy.isWithin(geometry2)
    try! italy.contains(geometry2)
    try! italy.overlaps(geometry2)
    try! italy.isTopologicallyEquivalent(to: geometry2)
    try! italy.relate(geometry2, mask: "T*****FF*")
}
