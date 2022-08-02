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

class CANMTITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMTIFromDatagram() throws {
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .one, .zero, .one, .one]), data: [])
        XCTAssertTrue(frame.isOpenLCBMessage)
        XCTAssertEqual(.datagramCompleteInFrame, frame.type)
        XCTAssertEqual(CommonMTI.datagram.rawValue, MTI(frame: frame))
    }

    func testMTIFromStream() throws {
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .one, .one, .one, .one, .one]), data: [])
        XCTAssertTrue(frame.isOpenLCBMessage)
        XCTAssertEqual(.streamData, frame.type)
        XCTAssertEqual(CommonMTI.streamDataSend.rawValue, MTI(frame: frame))
    }

    func testMTIFromXpressnet() throws {
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .zero, .zero, .one, .one]), data: [])
        XCTAssertTrue(frame.isOpenLCBMessage)
        XCTAssertEqual(.globalAddressedMTI, frame.type)
        XCTAssertEqual(0x820, frame.CANMTI)
        XCTAssertEqual(CommonMTI.xpressnet.rawValue, MTI(frame: frame))
    }

    func testMTIFrom0x0000() throws {
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .one, .one]), data: [])
        XCTAssertTrue(frame.isOpenLCBMessage)
        XCTAssertEqual(.globalAddressedMTI, frame.type)
        XCTAssertEqual(0x0000, MTI(frame: frame)?.rawValue)
    }

    func testNonOpenLCBMessageMTI() throws {
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero]), data: [])
        XCTAssertFalse(frame.isOpenLCBMessage)
        XCTAssertNil(MTI(frame: frame))
    }

    func testInvalidMessageMTI() throws {
        // type == 0
        // swiftlint:disable:next line_length
        let frame = CANFrame(header: CANHeader(bits: [.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero, .one, .one]), data: [])
        XCTAssertTrue(frame.isOpenLCBMessage)
        XCTAssertEqual(.reserved, frame.type)
        XCTAssertNil(MTI(frame: frame))
    }
}
