//
//  UtilitiesTests.swift
//  
//
//  Created by Randall Wood on 6/21/22.
//

@testable import OpenLCB
import XCTest

class UtilitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBytesFromInt() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytesFromInt(0x010203040506, count: 6))
        XCTAssertEqual([0, 0, 0, 0, 0, 0], Utilities.bytesFromInt(0x0, count: 6))
    }

    func testBytesFromIntTooLargeCount() {
        XCTAssertEqual([0, 1, 2, 3, 4, 5], Utilities.bytesFromInt(0x0102030405, count: 6))
    }

    func testBytesFromUInt64() {
        XCTAssertEqual([0, 0, 0, 1, 2, 3, 4, 5], Utilities.bytesFromInt(UInt64(0x0102030405)))
    }

    func testBytesFromUInt16() {
        XCTAssertEqual([1, 2], Utilities.bytesFromInt(UInt16(0x0102)))
    }

    func testBytesFromHexString() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytesFromHexString("1.2.3.4.5.6"))
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytesFromHexString("1 2 3 4 5 6"))
        XCTAssertEqual([], Utilities.bytesFromHexString("There are no hex tokens in this string"))
    }

    func testIntFromBytes() {
        XCTAssertEqual(0x010203040506, Utilities.intFromBytes([1, 2, 3, 4, 5, 6]))
        XCTAssertEqual(0x0102030405, Utilities.intFromBytes([0, 1, 2, 3, 4, 5]))
    }

    func testUInt64FromBytes() {
        XCTAssertEqual(0x010203040506, Utilities.uInt64FromBytes([1, 2, 3, 4, 5, 6]))
        XCTAssertEqual(0x0102030405, Utilities.uInt64FromBytes([0, 1, 2, 3, 4, 5]))
        XCTAssertEqual(0x100, Utilities.uInt64FromBytes([0, 0, 0, 0, 0, 0, 0, 0, 1, 0]))
    }
}
