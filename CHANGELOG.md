## 5.0.0

* Updates to GEOSwift 11.0.0
* Increases min Swift version to 5.9
* Increases min deployment targets for Apple platforms
* Expands QuickLook support to tvOS
* Fixes some warnings when building with Xcode 16

## 4.0.0

* Updates to GEOSwift 10.0.0
* Fixes build error on macCatalyst
* Increases min Swift version to 5.5
* Drops support for Carthage

## 3.0.0

* Updated for Xcode 12
    * Drops support for iOS 8
    * Switches to SPM as primary development environment
    * Updates GEOSwiftMapKit.xcodeproj to use GEOSwift.xcframework and
      geos.xcframework instead of the old-style fat frameworks due to a change
      in Xcode 12.3. This breaks (hopefully only temporarily) compatibility
      with Carthage unless you use the as-of-yet-unreleased Carthage version
      which adds the `--use-xcframeworks` flag. Carthage support will be
      reevaluated as its situation evolves.
* Increases min GEOSwift to 8.0.0

## 2.0.0

* [#9](https://github.com/GEOSwift/GEOSwiftMapKit/pull/9) Update to GEOSwift 7

## 1.2.0

* [#7](https://github.com/GEOSwift/GEOSwiftMapKit/pull/7) Swift PM Support
    * Add support for Swift PM on iOS, tvOS, and macOS (Fixes
      [#4](https://github.com/GEOSwift/GEOSwiftMapKit/issues/4))

## 1.1.0

* Relaxed GEOSwift dependency requirement for CocoaPods
* Added support for MKMultiPolyline and MKMultiPolygon

## 1.0.0

* Spun out of GEOSwift as part of its v5 rewrite
