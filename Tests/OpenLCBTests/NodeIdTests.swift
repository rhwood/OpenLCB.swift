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

class NodeIdTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyInit() {
        let node1: NodeId = NodeId()
        XCTAssertEqual([0, 0, 0, 0, 0, 0], node1.bytes)
    }

    func testTooLongBytes() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6, 7])
        let node2 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        XCTAssertEqual(node1, node2)
    }

    func testTooShortBytes() {
        XCTAssertThrowsError(try NodeId(bytes: [1, 2, 3, 4, 5]))
    }

    func testOkBytes() {
        XCTAssertEqual([1, 2, 3, 4, 5, 6], try NodeId(bytes: [1, 2, 3, 4, 5, 6]).bytes)
    }

    func testEmptyStringValue() {
        XCTAssertThrowsError(try NodeId(value: ""))
    }

    func testTooLongStringValue() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        let node2 = try NodeId(value: "1.2.3.4.5.6.7")
        XCTAssertEqual(node1, node2)
    }

    func testTooShortStringValue() throws {
        XCTAssertThrowsError(try NodeId(value: "1 2 3 4 5"))
    }

    func testOkStringValue() throws {
        let node1 = try NodeId(value: "1 2 3 4 5 6")
        let node2 = try NodeId(value: "1.2.3.4.5.6")
        XCTAssertEqual(node1, node2)
    }

    func testInt() throws {
        let node = NodeId(value: 0x998877FFEEDD)
        XCTAssertEqual([153, 136, 119, 255, 238, 221], node.bytes)
        XCTAssertEqual("99.88.77.FF.EE.DD", node.description)
    }

    func testNodeInit() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        let node2 = NodeId(node: node1)
        XCTAssertEqual(node1, node2)
    }

    func testEqualsSame() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        let node2 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        XCTAssertEqual(node1, node2)
    }

    func testEqualsSameString() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        let node2 = try NodeId(value: "1.2.3.4.5.6")
        XCTAssertEqual(node1, node2)
    }

    func testEqualsSelf() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        XCTAssertEqual(node1, node1)
    }

    func testNotEquals() throws {
        let node1 = try NodeId(bytes: [1, 2, 3, 4, 5, 6])
        let node2 = try NodeId(bytes: [6, 5, 4, 3, 2, 1])
        XCTAssertNotEqual(node1, node2)
    }

    func testOutputFormat() throws {
        XCTAssertEqual("01.10.13.0D.D0.AB", try NodeId(bytes: [1, 0x10, 0x13, 0x0D, 0xD0, 0xAB]).description)
    }

    func testRawValue() throws {
        let node = NodeId(rawValue: 0x010203040506)
        XCTAssertNotNil(node)
        XCTAssertEqual(0x010203040506, node?.rawValue)
        XCTAssertNotNil(NodeId(rawValue: 0x000000000000))
        XCTAssertNotNil(NodeId(rawValue: 0xFFFFFFFFFFFF))
    }
}
