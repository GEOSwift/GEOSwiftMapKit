# GEOSwiftMapKit

[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/GEOSwiftMapKit)](https://cocoapods.org/pods/GEOSwiftMapKit)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen)](https://github.com/Carthage/Carthage)
[![Supported Platforms](https://img.shields.io/cocoapods/p/GEOSwiftMapKit)](https://github.com/GEOSwift/GEOSwiftMapKit)
[![Build Status](https://img.shields.io/travis/GEOSwift/GEOSwiftMapKit/master)](https://travis-ci.org/GEOSwift/GEOSwiftMapKit)
[![Code Coverage](https://img.shields.io/codecov/c/github/GEOSwift/GEOSwiftMapKit/master)](https://codecov.io/gh/GEOSwift/GEOSwiftMapKit)

See [GEOSwift](https://github.com/GEOSwift/GEOSwift) for full details

## Requirements

* iOS 8.0+, tvOS 9.2+, macOS 10.9+
* Xcode 10.2
* Swift 5.0

## Installation

### CocoaPods

1. Install autotools: `$ brew install autoconf automake libtool`
2. Update your `Podfile` to include:

```
use_frameworks!
pod 'GEOSwiftMapKit'
```

3. Run `$ pod install`

> GEOS is a configure/install project licensed under LGPL 2.1: it is difficult to build for iOS and its compatibility with static linking is at least controversial. Use of GEOSwift without dynamic-framework-based CocoaPods and with a project targeting iOS 7, even if possible, is advised against.

### Carthage

1. Install autotools: `$ brew install autoconf automake libtool`
2. Add the following to your Cartfile:

```
github "GEOSwift/GEOSwiftMapKit" ~> 1.1.0
```

3. Finish updating your project by following the [typical Carthage
workflow](https://github.com/Carthage/Carthage#quick-start).

### Playground

Explore more, interactively, in the playground. It can be found inside `GEOSwiftMapKit` workspace. Open the workspace in Xcode, build the `GEOSwiftMapKit` framework and open the playground file.

![Playground](/README-images/playground.png)

## Contributing

To make a contribution:

* Fork the repo
* Start from the `develop` branch and create a branch with a name that describes your contribution
* Run `$ carthage update`
* Sign in to travis-ci.org (if you've never signed in before, CI won't run to verify your pull request)
* Push your branch and create a pull request to develop
* One of the maintainers will review your code and may request changes
* If your pull request is accepted, one of the maintainers should update the changelog before merging it

## Maintainer

* Andrew Hershberger ([@macdrevx](https://github.com/macdrevx))

## Past Maintainers

* Virgilio Favero Neto ([@vfn](https://github.com/vfn))
* Andrea Cremaschi ([@andreacremaschi](https://twitter.com/andreacremaschi)) (original author)

## License

* GEOSwift was released by Andrea Cremaschi ([@andreacremaschi](https://twitter.com/andreacremaschi)) under a MIT license. See LICENSE for more information.
* [GEOS](http://trac.osgeo.org/geos/) stands for Geometry Engine - Open Source, and is a C++ library, ported from the [Java Topology Suite](http://sourceforge.net/projects/jts-topo-suite/). GEOS implements the OpenGIS [Simple Features for SQL](http://www.opengeospatial.org/standards/sfs) spatial predicate functions and spatial operators. GEOS, now an OSGeo project, was initially developed and maintained by [Refractions Research](http://www.refractions.net/) of Victoria, Canada.
