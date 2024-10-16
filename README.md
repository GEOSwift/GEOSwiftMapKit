# GEOSwiftMapKit

[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/GEOSwiftMapKit)](https://cocoapods.org/pods/GEOSwiftMapKit)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![Supported Platforms](https://img.shields.io/cocoapods/p/GEOSwiftMapKit)](https://github.com/GEOSwift/GEOSwiftMapKit)
[![Build Status](https://github.com/GEOSwift/GEOSwiftMapKit/actions/workflows/main.yml/badge.svg)](https://github.com/GEOSwift/GEOSwiftMapKit/actions/workflows/main.yml)

See [GEOSwift](https://github.com/GEOSwift/GEOSwift) for full details

## Minimum Requirements

* iOS 12.0, tvOS 12.0, macOS 10.13
* Swift 5.9 compiler

> GEOS is licensed under LGPL 2.1 and its compatibility with static linking is
at least controversial. Use of geos without dynamic linking is discouraged.

## Installation

### CocoaPods

1. Update your `Podfile` to include:

        use_frameworks!
        pod 'GEOSwiftMapKit'

2. Run `$ pod install`

### Swift Package Manager

1. Update the top-level dependencies in your `Package.swift` to include:

        .package(url: "https://github.com/GEOSwift/GEOSwiftMapKit.git", from: "5.0.0")

2. Update the target dependencies in your `Package.swift` to include

        "GEOSwiftMapKit"

### Playground

Explore more, interactively, in the playground. Open Package.swift in Xcode,
and open the playground file from the file navigator.

![Playground](/README-images/playground.png)

## Contributing

To make a contribution:

* Fork the repo
* Start from the `main` branch and create a branch with a name that describes
  your contribution
* Run `$ xed Package.swift` to open the project in Xcode.
* Run `$ swiftlint` from the repo root and resolve any issues.
* Push your branch and create a pull request to `main`
* One of the maintainers will review your code and may request changes
* If your pull request is accepted, one of the maintainers should update the
  changelog before merging it

## Maintainer

* Andrew Hershberger ([@macdrevx](https://github.com/macdrevx))

## Past Maintainers

* Virgilio Favero Neto ([@vfn](https://github.com/vfn))
* Andrea Cremaschi ([@andreacremaschi](https://twitter.com/andreacremaschi))
  (original author)

## License

* GEOSwift was released by Andrea Cremaschi
  ([@andreacremaschi](https://twitter.com/andreacremaschi)) under a MIT license.
  See LICENSE for more information.
* [GEOS](http://trac.osgeo.org/geos/) stands for Geometry Engine - Open Source,
  and is a C++ library, ported from the
  [Java Topology Suite](http://sourceforge.net/projects/jts-topo-suite/). GEOS
  implements the OpenGIS
  [Simple Features for SQL](http://www.opengeospatial.org/standards/sfs) spatial
  predicate functions and spatial operators. GEOS, now an OSGeo project, was
  initially developed and maintained by
  [Refractions Research](http://www.refractions.net/) of Victoria, Canada.
