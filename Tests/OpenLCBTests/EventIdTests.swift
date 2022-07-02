//
//  EventIdTest.swift
//  
//
//  Created by Randall Wood on 6/20/22.
//

@testable import OpenLCB
import XCTest

class EventIdTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTooLongBytes() throws {
        XCTAssertThrowsError(try EventId(bytes: [1,2,3,4,5,6,7,8,9]))
    }
    
    func testTooShortBytes() {
        XCTAssertThrowsError(try EventId(bytes: [1,2,3,4,5]))
    }
    
    func testOkBytes() {
        XCTAssertEqual([1,2,3,4,5,6,7,8], try EventId(bytes: [1,2,3,4,5,6,7,8]).bytes)
    }

    func testEmptyStringValue() {
        XCTAssertThrowsError(try EventId(value: ""))
    }
    
    func testTooLongStringValue() throws {
        XCTAssertThrowsError(try EventId(value: "1.2.3.4.5.6.7.8.9"))
    }
    
    func testTooShortStringValue() throws {
        XCTAssertThrowsError(try EventId(value: "1 2 3 4 5"))
    }

    func testOkStringValue() throws {
        let e1 = try EventId(value: "1 2 3 4 5 6 7 8")
        let e2 = try EventId(value: "1.2.3.4.5.6.7.8")
        XCTAssertEqual(e1, e2)
    }

    func testInt() throws {
        let e = EventId(value: 0x998877FFEEDD0112)
        XCTAssertEqual([153, 136, 119, 255, 238, 221, 1, 18], e.bytes)
        XCTAssertEqual("99.88.77.FF.EE.DD.01.12", e.description)
    }
    
    func testEqualsSame() throws {
        let e1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let e2 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(e1, e2)
    }
    
    func testEqualsSameString() throws {
        let e1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let e2 = try EventId(value: "1.2.3.4.5.6.7.8")
        XCTAssertEqual(e1, e2)
    }
    
    func testEqualsSelf() throws {
        let e1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(e1, e1)
    }
    
    func testNotEquals() throws {
        let e1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let e2 = try EventId(bytes: [8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssertNotEqual(e1, e2)
    }
    
    func testOutputFormat() throws {
        XCTAssertEqual("01.10.13.0D.D0.AB.CD.AB", try EventId(bytes: [1,0x10,0x13,0x0D,0xD0,0xAB,0xCD,0xAB]).description)
    }

    func testRawValue() throws {
        let e = EventId(rawValue: 0x0102030405060708)
        XCTAssertNotNil(e)
        XCTAssertEqual(0x0102030405060708, e?.rawValue)
    }

    func testNodeSuffixInit() throws {
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0xA, 0xA], EventId(node: NodeId(), suffix: 0xA0A).bytes)
    }

    func testNodeIdSuffixProperties() throws {
        let e = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual([1, 2, 3, 4, 5, 6], e.nodeID.bytes)
        XCTAssertEqual(0x708, e.suffix)
    }
}
