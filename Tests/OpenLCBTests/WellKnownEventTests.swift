//
//  WellKnownEventTests.swift
//  
//
//  Created by Randall Wood on 6/23/22.
//

import XCTest
import OpenLCB

class WellKnownEventTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testId() throws {
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0xFF, 0xFF], WellKnownEvent.emergencyOff.id.bytes)
    }

    func testIsWellKnown() throws {
        XCTAssertTrue(WellKnownEvent.isWellKnown(WellKnownEvent.emergencyOff.id))
        XCTAssertTrue(WellKnownEvent.isWellKnown(EventId(value: 0xFFFF)))
        XCTAssertFalse(WellKnownEvent.isWellKnown(EventId(value: 0xFFFFFFFFFFFFFFFF)))
    }
}
