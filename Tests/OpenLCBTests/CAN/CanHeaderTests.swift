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

class CANHeaderTests: XCTestCase {

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
        XCTAssertEqual(xpressnet, CANHeader(bits: xpressnet).bits)
        XCTAssertEqual(stream, CANHeader(bits: stream).bits)
    }

    func testPrefix() {
        XCTAssertEqual(3, CANHeader(bits: xpressnet).prefix)
        XCTAssertEqual(3, CANHeader(bits: stream).prefix)
    }

    func testType() {
        XCTAssertEqual(.globalAddressedMTI, CANHeader(bits: xpressnet).type)
        XCTAssertEqual(.streamData, CANHeader(bits: stream).type)
    }

    func testIsOpenLCBMessage() {
        XCTAssertTrue(CANHeader(bits: xpressnet).isOpenLCBMessage)
        XCTAssertTrue(CANHeader(bits: stream).isOpenLCBMessage)
    }

    func testIsCANControlFrame() {
        XCTAssertFalse(CANHeader(bits: xpressnet).isCANControlFrame)
        XCTAssertFalse(CANHeader(bits: stream).isCANControlFrame)
    }

    func testCANMTI() {
        XCTAssertEqual(0x820, CANHeader(bits: xpressnet).CANMTI)
        XCTAssertNil(CANHeader(bits: stream).CANMTI)
    }

    func testDestinationAlias() {
        XCTAssertNil(CANHeader(bits: xpressnet).destinationAlias)
        XCTAssertEqual(0x820, CANHeader(bits: stream).destinationAlias)
    }

    func testSourceAlias() {
        XCTAssertEqual(0xFFF, CANHeader(bits: xpressnet).sourceAlias)
        XCTAssertEqual(0xFFF, CANHeader(bits: stream).sourceAlias)
    }

    func testVariable() {
        // swiftlint:disable:next line_length
        XCTAssertEqual([.zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .zero, .zero], CANHeader(bits: xpressnet).variable)
        // swiftlint:disable:next line_length
        XCTAssertEqual([.zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .one, .one], CANHeader(bits: stream).variable)
    }
}
