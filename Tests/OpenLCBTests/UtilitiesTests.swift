// Copyright 2022 Randall Wood
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytes(0x010203040506, count: 6))
        XCTAssertEqual([0, 0, 0, 0, 0, 0], Utilities.bytes(0x0, count: 6))
    }

    func testBytesFromIntTooLargeCount() {
        XCTAssertEqual([0, 1, 2, 3, 4, 5], Utilities.bytes(0x0102030405, count: 6))
    }

    func testBytesFromUInt64() {
        XCTAssertEqual([0, 0, 0, 1, 2, 3, 4, 5], Utilities.bytes(UInt64(0x0102030405)))
    }

    func testBytesFromUInt16() {
        XCTAssertEqual([1, 2], Utilities.bytes(UInt16(0x0102)))
    }

    func testBytesFromHexString() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytes("1.2.3.4.5.6"))
        XCTAssertEqual([1, 2, 3, 4, 5, 6], Utilities.bytes("1 2 3 4 5 6"))
        XCTAssertEqual([], Utilities.bytes("There are no hex tokens in this string"))
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

    func testBits() {
        XCTAssertEqual([.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero], Utilities.bits(UInt8(0)))
        XCTAssertEqual([.one, .zero, .zero, .zero, .zero, .zero, .zero, .zero], Utilities.bits(UInt8(1)))
        XCTAssertEqual([.zero, .one, .zero, .zero, .zero, .zero, .zero, .zero], Utilities.bits(UInt8(2)))
    }

    func testBitDescription() {
        XCTAssertEqual("0", Bit.zero.description)
        XCTAssertEqual("1", Bit.one.description)
    }

    func testNibble() {
        XCTAssertEqual(0, [.zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(1, [.one, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(2, [.zero, .one, .zero, .zero].nibble(0))
        XCTAssertEqual(4, [.zero, .zero, .one, .zero].nibble(0))
        XCTAssertEqual(8, [.zero, .zero, .zero, .one].nibble(0))
        XCTAssertEqual(15, [.one, .one, .one, .one].nibble(0))
        XCTAssertEqual(0, [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(1, [.one, .zero, .zero, .zero, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(2, [.zero, .one, .zero, .zero, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(4, [.zero, .zero, .one, .zero, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(8, [.zero, .zero, .zero, .one, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(15, [.one, .one, .one, .one, .zero, .zero, .zero, .zero].nibble(0))
        XCTAssertEqual(0, [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero].nibble(4))
        XCTAssertEqual(1, [.zero, .zero, .zero, .zero, .one, .zero, .zero, .zero].nibble(4))
        XCTAssertEqual(2, [.zero, .zero, .zero, .zero, .zero, .one, .zero, .zero].nibble(4))
        XCTAssertEqual(4, [.zero, .zero, .zero, .zero, .zero, .zero, .one, .zero].nibble(4))
        XCTAssertEqual(8, [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .one].nibble(4))
        XCTAssertEqual(15, [.zero, .zero, .zero, .zero, .one, .one, .one, .one].nibble(4))
        XCTAssertEqual(0, Utilities.bits(0).nibble(0))
        XCTAssertEqual(1, Utilities.bits(1).nibble(0))
        XCTAssertEqual(2, Utilities.bits(2).nibble(0))
        XCTAssertEqual(4, Utilities.bits(4).nibble(0))
        XCTAssertEqual(8, Utilities.bits(8).nibble(0))
        XCTAssertEqual(15, Utilities.bits(15).nibble(0))
    }

    func testByte() {
        XCTAssertEqual(0, [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero].byte(0))
        XCTAssertEqual(1, [.one, .zero, .zero, .zero, .zero, .zero, .zero, .zero].byte(0))
        XCTAssertEqual(2, [.zero, .one, .zero, .zero, .zero, .zero, .zero, .zero].byte(0))
        XCTAssertEqual(64, [.zero, .zero, .zero, .zero, .zero, .zero, .one, .zero].byte(0))
        XCTAssertEqual(128, [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .one].byte(0))
        XCTAssertEqual(255, [.one, .one, .one, .one, .one, .one, .one, .one].byte(0))
        XCTAssertEqual(0, Utilities.bits(UInt8(0)).byte(0))
        XCTAssertEqual(1, Utilities.bits(UInt8(1)).byte(0))
        XCTAssertEqual(2, Utilities.bits(UInt8(2)).byte(0))
        XCTAssertEqual(64, Utilities.bits(UInt8(64)).byte(0))
        XCTAssertEqual(128, Utilities.bits(UInt8(128)).byte(0))
        XCTAssertEqual(255, Utilities.bits(UInt8(255)).byte(0))
        XCTAssertEqual(0, Utilities.bits(UInt64(0)).byte(0))
        XCTAssertEqual(1, Utilities.bits(UInt64(1)).byte(0))
        XCTAssertEqual(2, Utilities.bits(UInt64(2)).byte(0))
        XCTAssertEqual(64, Utilities.bits(UInt64(64)).byte(0))
        XCTAssertEqual(128, Utilities.bits(UInt64(128)).byte(0))
        XCTAssertEqual(255, Utilities.bits(UInt64(255)).byte(0))
    }

    func testLazyVar() {
        struct TestStruct {
            private let _testVar: LazyVar<TestStruct, Int> = LazyVar { _ in
                42
            }
            var testVar: Int {
                _testVar.lazy(self)
            }
        }
        let ts1 = TestStruct()
        XCTAssertEqual(42, ts1.testVar)
    }

    func testByteString() {
        XCTAssertEqual("0xFF.FF", Utilities.byteString(UInt16(0xFFFF)))
        XCTAssertEqual("0x00.00", Utilities.byteString(UInt16(0x0000)))
        XCTAssertEqual("0x00.00.00.00.00.00.FF.FF", Utilities.byteString(UInt64(0xFFFF)))
        XCTAssertEqual("0x00.00.00.00.00.00.00.00", Utilities.byteString(UInt64(0x0000)))
        XCTAssertEqual("0x01.02.03.04.05.06", Utilities.byteString([1, 2, 3, 4, 5, 6]))
        XCTAssertEqual("0xFF FF", Utilities.byteString(UInt16(0xFFFF), separator: " "))
        XCTAssertEqual("0x00 00", Utilities.byteString(UInt16(0x0000), separator: " "))
        XCTAssertEqual("0x00 00 00 00 00 00 FF FF", Utilities.byteString(UInt64(0xFFFF), separator: " "))
        XCTAssertEqual("0x00 00 00 00 00 00 00 00", Utilities.byteString(UInt64(0x0000), separator: " "))
        XCTAssertEqual("0x01 02 03 04 05 06", Utilities.byteString([1, 2, 3, 4, 5, 6], separator: " "))
    }
}
