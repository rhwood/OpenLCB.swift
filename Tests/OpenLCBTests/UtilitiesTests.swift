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

    func testLazyVar() {
        struct testStruct {
            private let _testVar: LazyVar<testStruct, Int> = LazyVar {
                _ in 42
            }
            var testVar: Int {
                _testVar.lazy(self)
            }
        }
        let ts = testStruct()
        XCTAssertEqual(42, ts.testVar)
    }

    func testByteString() {
        XCTAssertEqual("FF.FF", Utilities.byteString(UInt16(0xFFFF)))
        XCTAssertEqual("00.00", Utilities.byteString(UInt16(0x0000)))
        XCTAssertEqual("00.00.00.00.00.00.FF.FF", Utilities.byteString(UInt64(0xFFFF)))
        XCTAssertEqual("00.00.00.00.00.00.00.00", Utilities.byteString(UInt64(0x0000)))
        XCTAssertEqual("01.02.03.04.05.06", Utilities.byteString([1, 2, 3, 4, 5, 6]))
    }
}
