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

class EventIdTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTooLongBytes() throws {
        XCTAssertThrowsError(try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8, 9]))
    }

    func testTooShortBytes() {
        XCTAssertThrowsError(try EventId(bytes: [1, 2, 3, 4, 5]))
    }

    func testOkBytes() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6, 7, 8], try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8]).bytes)
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
        let event1 = try EventId(value: "1 2 3 4 5 6 7 8")
        let event2 = try EventId(value: "1.2.3.4.5.6.7.8")
        XCTAssertEqual(event1, event2)
    }

    func testInt() throws {
        let event1 = EventId(value: 0x998877FFEEDD0112)
        XCTAssertEqual([153, 136, 119, 255, 238, 221, 1, 18], event1.bytes)
        XCTAssertEqual("0x99.88.77.FF.EE.DD.01.12", event1.description)
    }

    func testEqualsSame() throws {
        let event1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let event2 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(event1, event2)
    }

    func testEqualsSameString() throws {
        let event1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let event2 = try EventId(value: "1.2.3.4.5.6.7.8")
        XCTAssertEqual(event1, event2)
    }

    func testEqualsSelf() throws {
        let event1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual(event1, event1)
    }

    func testNotEquals() throws {
        let event1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        let event2 = try EventId(bytes: [8, 7, 6, 5, 4, 3, 2, 1])
        XCTAssertNotEqual(event1, event2)
    }

    func testOutputFormat() throws {
        XCTAssertEqual("0x01.10.13.0D.D0.AB.CD.AB",
                       try EventId(bytes: [1, 0x10, 0x13, 0x0D, 0xD0, 0xAB, 0xCD, 0xAB]).description)
    }

    func testRawValue() throws {
        let event1 = EventId(rawValue: 0x0102030405060708)
        XCTAssertNotNil(event1)
        XCTAssertEqual(0x0102030405060708, event1?.rawValue)
    }

    func testNodeSuffixInit() throws {
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0xA, 0xA], EventId(node: NodeId(), suffix: 0xA0A).bytes)
    }

    func testNodeIdSuffixProperties() throws {
        let event1 = try EventId(bytes: [1, 2, 3, 4, 5, 6, 7, 8])
        XCTAssertEqual([1, 2, 3, 4, 5, 6], event1.nodeID.bytes)
        XCTAssertEqual(0x708, event1.suffix)
    }
}
