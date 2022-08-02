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

    func testRawValueInit() {
        XCTAssertNotNil(MTI(rawValue: 0x0000))
        XCTAssertNotNil(MTI(rawValue: 0xFFFF))
        XCTAssertEqual(MTI(rawValue: 0x1234), MTI(value: 0x1234))
    }

    func testIntegerLiteralInit() {
        var mti: MTI = 0
        XCTAssertNotNil(mti)
        XCTAssertEqual(0, mti.rawValue)
        mti = 0xFFFF
        XCTAssertNotNil(mti)
        XCTAssertEqual(0xFFFF, mti.rawValue)
        mti = 0x1234
        XCTAssertNotNil(mti)
        XCTAssertEqual(0x1234, mti.rawValue)
    }

    func testSpecial() {
        XCTAssertFalse(CommonMTI.initializationComplete.rawValue.special)
        XCTAssertFalse(CommonMTI.tractionControlCommand.rawValue.special)
        XCTAssertFalse(CommonMTI.datagram.rawValue.special)
        XCTAssertTrue(CommonMTI.nodeNumberAllocate.rawValue.special)
        XCTAssertTrue(MTI(value: 0xFFFF).special)
        XCTAssertFalse(MTI(value: 0x0000).special)
    }

    func testStreamOrDatagram() {
        XCTAssertFalse(CommonMTI.initializationComplete.rawValue.streamOrDatagram)
        XCTAssertFalse(CommonMTI.tractionControlCommand.rawValue.streamOrDatagram)
        XCTAssertTrue(CommonMTI.datagram.rawValue.streamOrDatagram)
        XCTAssertFalse(CommonMTI.nodeNumberAllocate.rawValue.streamOrDatagram)
        XCTAssertTrue(MTI(value: 0xFFFF).streamOrDatagram)
        XCTAssertFalse(MTI(value: 0x0000).streamOrDatagram)
    }

    func testPriority() {
        XCTAssertEqual(0, CommonMTI.initializationComplete.rawValue.priority)
        XCTAssertEqual(1, CommonMTI.tractionControlCommand.rawValue.priority)
        XCTAssertEqual(3, CommonMTI.datagram.rawValue.priority)
        XCTAssertEqual(0, CommonMTI.nodeNumberAllocate.rawValue.priority)
        XCTAssertEqual(3, MTI(value: 0xFFFF).priority)
        XCTAssertEqual(0, MTI(value: 0x0000).priority)
    }

    func testType() {
        XCTAssertEqual(8, CommonMTI.initializationComplete.rawValue.type)
        XCTAssertEqual(15, CommonMTI.tractionControlCommand.rawValue.type)
        XCTAssertEqual(2, CommonMTI.datagram.rawValue.type)
        XCTAssertEqual(0, CommonMTI.nodeNumberAllocate.rawValue.type)
        XCTAssertEqual(31, MTI(value: 0xFFFF).type)
        XCTAssertEqual(0, MTI(value: 0x0000).type)
    }

    func testSimpleProtocol() {
        XCTAssertFalse(CommonMTI.initializationComplete.rawValue.simpleProtocol)
        XCTAssertFalse(CommonMTI.tractionControlCommand.rawValue.simpleProtocol)
        XCTAssertFalse(CommonMTI.datagram.rawValue.simpleProtocol)
        XCTAssertFalse(CommonMTI.nodeNumberAllocate.rawValue.simpleProtocol)
        XCTAssertTrue(MTI(value: 0xFFFF).simpleProtocol)
        XCTAssertFalse(MTI(value: 0x0000).simpleProtocol)
    }

    func testAddressPresent() throws {
        XCTAssertFalse(CommonMTI.initializationComplete.rawValue.addressPresent)
        XCTAssertTrue(CommonMTI.tractionControlCommand.rawValue.addressPresent)
        XCTAssertTrue(CommonMTI.datagram.rawValue.addressPresent)
        XCTAssertFalse(CommonMTI.nodeNumberAllocate.rawValue.addressPresent)
        XCTAssertTrue(MTI(value: 0xFFFF).eventPresent)
        XCTAssertFalse(MTI(value: 0x0000).eventPresent)
    }

    func testEventPresent() throws {
        XCTAssertFalse(CommonMTI.initializationComplete.rawValue.eventPresent)
        XCTAssertFalse(CommonMTI.tractionControlCommand.rawValue.eventPresent)
        XCTAssertFalse(CommonMTI.datagram.rawValue.eventPresent)
        XCTAssertFalse(CommonMTI.nodeNumberAllocate.rawValue.eventPresent)
        XCTAssertTrue(MTI(value: 0xFFFF).eventPresent)
        XCTAssertFalse(MTI(value: 0x0000).eventPresent)
    }

    func testModifier() throws {
        XCTAssertEqual(0, CommonMTI.initializationComplete.rawValue.modifier)
        XCTAssertEqual(3, CommonMTI.tractionControlCommand.rawValue.modifier)
        XCTAssertEqual(0, CommonMTI.datagram.rawValue.modifier)
        XCTAssertEqual(0, CommonMTI.nodeNumberAllocate.rawValue.modifier)
        XCTAssertEqual(3, MTI(value: 0xFFFF).modifier)
        XCTAssertEqual(0, MTI(value: 0x0000).modifier)
    }

    func testDescription() {
        XCTAssertEqual("Initialization Complete", CommonMTI.initializationComplete.rawValue.description)
        XCTAssertEqual("Traction Control Command", CommonMTI.tractionControlCommand.rawValue.description)
        XCTAssertEqual("Datagram", CommonMTI.datagram.rawValue.description)
        XCTAssertEqual("Node Number Allocate", CommonMTI.nodeNumberAllocate.rawValue.description)
        XCTAssertEqual("Unknown MTI: 0xFF.FF", MTI(value: 0xFFFF).description)
        XCTAssertEqual("Unknown MTI: 0x00.00", MTI(value: 0x0000).description)
    }
}
