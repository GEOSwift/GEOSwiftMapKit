# GEOSwiftMapKit

[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/GEOSwiftMapKit)](https://cocoapods.org/pods/GEOSwiftMapKit)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen)](https://github.com/Carthage/Carthage)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![Supported Platforms](https://img.shields.io/cocoapods/p/GEOSwiftMapKit)](https://github.com/GEOSwift/GEOSwiftMapKit)
[![Build Status](https://img.shields.io/travis/GEOSwift/GEOSwiftMapKit/main)](https://travis-ci.com/GEOSwift/GEOSwiftMapKit)
[![Code Coverage](https://img.shields.io/codecov/c/github/GEOSwift/GEOSwiftMapKit/main)](https://codecov.io/gh/GEOSwift/GEOSwiftMapKit)

See [GEOSwift](https://github.com/GEOSwift/GEOSwift) for full details

## Requirements

* iOS 9.0+, tvOS 9.2+, macOS 10.9+ (CocoaPods, Carthage, Swift PM)
* Swift 5.1

> GEOS is licensed under LGPL 2.1 and its compatibility with static linking is
at least controversial. Use of geos without dynamic linking is discouraged.

## Installation

### CocoaPods

1. Update your `Podfile` to include:

        use_frameworks!
        pod 'GEOSwiftMapKit'

2. Run `$ pod install`

### Carthage

1. Add the following to your Cartfile:

        github "GEOSwift/GEOSwiftMapKit" ~> 3.0.0

2. Finish updating your project by following the [typical Carthage
workflow](https://github.com/Carthage/Carthage#quick-start).

### Swift Package Manager

1. Update the top-level dependencies in your `Package.swift` to include:

        .package(url: "https://github.com/GEOSwift/GEOSwiftMapKit.git", from: "3.0.0")

2. Update the target dependencies in your `Package.swift` to include

        "GEOSwiftMapKit"

### Playground

Explore more, interactively, in the playground. Open the project in Xcode,
select the `GEOSwiftMapKit-iOS` scheme and open the playground file.

![Playground](/README-images/playground.png)

## Contributing

To make a contribution:

* Fork the repo
* Start from the `main` branch and create a branch with a name that describes
  your contribution
* Run `$ xed Package.swift` to open the project in Xcode.
* Run `$ swiftlint` from the repo root and resolve any issues.
* Update GEOSwiftMapKit.xcodeproj: After making your changes, you also need to
  update the Xcode project. You'll need a version of Carthage greater than 0.36.0
  so that you can use the `--use-xcframeworks` option. Run
  `$ carthage update --use-xcframeworks` to generate GEOSwift.xcframework and
  geos.xcframework. Then open the GEOSwiftMapKit.xcodeproj and ensure that it
  works with your changes. You'll likely only need to make changes if you've
  added, removed, or renamed files.
* Sign in to travis-ci.org (if you've never signed in before, CI won't run to
  verify your pull request)
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
