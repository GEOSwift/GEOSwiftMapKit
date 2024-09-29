import MapKit

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateSpan: @retroactive Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta
            && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateRegion: @retroactive Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center
            && lhs.span == rhs.span
    }
}

extension MKMapPoint: @retroactive Equatable {
    public static func == (lhs: MKMapPoint, rhs: MKMapPoint) -> Bool {
        lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}

extension MKMapSize: @retroactive Equatable {
    public static func == (lhs: MKMapSize, rhs: MKMapSize) -> Bool {
        lhs.width == rhs.width
            && lhs.height == rhs.height
    }
}

extension MKMapRect: @retroactive Equatable {
    public static func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
        lhs.origin == rhs.origin
            && lhs.size == rhs.size
    }
}
