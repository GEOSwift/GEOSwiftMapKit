Pod::Spec.new do |s|
  s.name = 'GEOSwiftMapKit'
  s.version = '1.1.0'
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'
  s.summary = 'MapKit support for GEOSwift'
  s.description  = <<~DESC
    Easily handle a geometric object model (points, linestrings, polygons etc.) and related
    topological operations (intersections, overlapping etc.). A type-safe, MIT-licensed Swift
    interface to the OSGeo's GEOS library routines, nicely integrated with MapKit.
  DESC
  s.homepage = 'https://github.com/GEOSwift/GEOSwiftMapKit'
  s.license = {
    type: 'MIT',
    file: 'LICENSE'
  }
  s.authors = 'Andrew Hershberger'
  s.platforms = { ios: "8.0", osx: "10.9", tvos: "9.2" }
  s.source = {
    git: 'https://github.com/GEOSwift/GEOSwiftMapKit.git',
    tag: s.version
  }
  s.source_files = 'GEOSwiftMapKit/*.{swift,h}'
  s.macos.exclude_files = 'GEOSwiftMapKit/GEOSwift+MapKitQuickLook.swift'
  s.dependency 'GEOSwift', '~> 5.0'
end
