//
//  MTITests.swift
//  
//
//  Created by Randall Wood on 7/19/22.
//

import XCTest
import OpenLCB

class MTITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStreamOrDatagram() {
        XCTAssertFalse(CommonMTI.initializationCompleteFullProtocolRequired.rawValue.streamOrDatagram)
        XCTAssertFalse(MTI(value: 0x05EB).streamOrDatagram)
        XCTAssertTrue(MTI(value: 0x1C48).streamOrDatagram)
        XCTAssertFalse(MTI(value: 0x2000).streamOrDatagram)
    }

    func testPriority() {
        XCTAssertEqual(0, CommonMTI.initializationCompleteFullProtocolRequired.rawValue.priority)
        XCTAssertEqual(1, MTI(value: 0x05EB).priority)
        XCTAssertEqual(3, MTI(value: 0x1C48).priority)
        XCTAssertEqual(0, MTI(value: 0x2000).priority)
    }

    func testType() {
        XCTAssertEqual(8, CommonMTI.initializationCompleteFullProtocolRequired.rawValue.type)
        XCTAssertEqual(15, MTI(value: 0x05EB).type)
        XCTAssertEqual(2, MTI(value: 0x1C48).type)
        XCTAssertEqual(0, MTI(value: 0x2000).type)
    }

    func testSimpleProtocol() {
        XCTAssertFalse(CommonMTI.initializationCompleteFullProtocolRequired.rawValue.simpleProtocol)
        XCTAssertFalse(MTI(value: 0x05EB).simpleProtocol)
        XCTAssertFalse(MTI(value: 0x1C48).simpleProtocol)
        XCTAssertFalse(MTI(value: 0x2000).simpleProtocol)
    }

    func testAddressPresent() throws {
        XCTAssertFalse(CommonMTI.initializationCompleteFullProtocolRequired.rawValue.addressPresent)
        XCTAssertTrue(MTI(value: 0x05EB).addressPresent)
        XCTAssertTrue(MTI(value: 0x1C48).addressPresent)
        XCTAssertFalse(MTI(value: 0x2000).addressPresent)
    }

    func testEventPresent() throws {
        XCTAssertFalse(CommonMTI.initializationCompleteFullProtocolRequired.rawValue.eventPresent)
        XCTAssertFalse(MTI(value: 0x05EB).eventPresent)
        XCTAssertFalse(MTI(value: 0x1C48).eventPresent)
        XCTAssertFalse(MTI(value: 0x2000).eventPresent)
    }

    func testModifier() throws {
        XCTAssertEqual(0, CommonMTI.initializationCompleteFullProtocolRequired.rawValue.modifier)
        XCTAssertEqual(3, MTI(value: 0x05EB).modifier)
        XCTAssertEqual(0, MTI(value: 0x1C48).modifier)
        XCTAssertEqual(0, MTI(value: 0x2000).modifier)
    }

}
