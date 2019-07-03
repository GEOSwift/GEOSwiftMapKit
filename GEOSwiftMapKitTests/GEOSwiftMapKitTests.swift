//
//  GEOSwiftMapKitTests.swift
//  GEOSwiftMapKitTests
//
//  Created by Andrew Hershberger on 6/26/19.
//

import XCTest
import GEOSwift
import GEOSwiftMapKit

final class GEOSwiftMapKitTests: XCTestCase {
    func testQuickLook() {
        try! Point(wkt: "POINT(10 45)").playgroundDescription
    }
}
