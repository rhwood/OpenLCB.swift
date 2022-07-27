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

class CanHeaderTests: XCTestCase {

    // swiftlint:disable:next line_length
    let xpressnet: [Bit] = [.one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .zero, .zero, .one, .one]
    // swiftlint:disable:next line_length
    let stream: [Bit] = [.one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .one, .one, .one, .one]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBits() throws {
        XCTAssertEqual(xpressnet, CanHeader(bits: xpressnet).bits)
        XCTAssertEqual(stream, CanHeader(bits: stream).bits)
    }

    func testPrefix() {
        XCTAssertEqual(3, CanHeader(bits: xpressnet).prefix)
        XCTAssertEqual(3, CanHeader(bits: stream).prefix)
    }

    func testType() {
        XCTAssertEqual(1, CanHeader(bits: xpressnet).type)
        XCTAssertEqual(7, CanHeader(bits: stream).type)
    }

    func testIsOpenLCBMessage() {
        XCTAssertTrue(CanHeader(bits: xpressnet).isOpenLCBMessage)
        XCTAssertTrue(CanHeader(bits: stream).isOpenLCBMessage)
    }

    func testIsCANControlFrame() {
        XCTAssertFalse(CanHeader(bits: xpressnet).isCANControlFrame)
        XCTAssertFalse(CanHeader(bits: stream).isCANControlFrame)
    }

    func testCanMTI() {
        XCTAssertEqual(0x820, CanHeader(bits: xpressnet).canMTI)
        XCTAssertNil(CanHeader(bits: stream).canMTI)
    }

    func testDestinationAlias() {
        XCTAssertNil(CanHeader(bits: xpressnet).destinationAlias)
        XCTAssertEqual(0x820, CanHeader(bits: stream).destinationAlias)
    }

    func testSourceAlias() {
        XCTAssertEqual(0xFFF, CanHeader(bits: xpressnet).sourceAlias)
        XCTAssertEqual(0xFFF, CanHeader(bits: stream).sourceAlias)
    }
}
