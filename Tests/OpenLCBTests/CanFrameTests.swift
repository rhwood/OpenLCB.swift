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

class CanFrameTests: XCTestCase {

    let xpressnet: [Bit] = [.one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .zero, .zero, .one, .one]
    let stream: [Bit] = [.one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .one, .zero, .zero, .zero, .zero, .zero, .one, .zero, .zero, .zero, .zero, .zero, .one, .one, .one, .one, .one, .one]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testData() throws {
        XCTAssertEqual([], CanFrame(header: CanHeader(bits: xpressnet), data: []).data)
        XCTAssertEqual([], CanFrame(header: CanHeader(bits: stream), data: []).data)
    }

    func testPrefix() {
        XCTAssertEqual(3, CanFrame(header: CanHeader(bits: xpressnet), data: []).prefix)
        XCTAssertEqual(3, CanFrame(header: CanHeader(bits: stream), data: []).prefix)
    }

    func testType() {
        XCTAssertEqual(1, CanFrame(header: CanHeader(bits: xpressnet), data: []).type)
        XCTAssertEqual(7, CanFrame(header: CanHeader(bits: stream), data: []).type)
    }

    func testIsOpenLCBMessage() {
        XCTAssertTrue(CanFrame(header: CanHeader(bits: xpressnet), data: []).isOpenLCBMessage)
        XCTAssertTrue(CanFrame(header: CanHeader(bits: stream), data: []).isOpenLCBMessage)
    }

    func testIsCANControlFrame() {
        XCTAssertFalse(CanFrame(header: CanHeader(bits: xpressnet), data: []).isCANControlFrame)
        XCTAssertFalse(CanFrame(header: CanHeader(bits: stream), data: []).isCANControlFrame)
    }

    func testCanMTI() {
        XCTAssertEqual(0x820, CanFrame(header: CanHeader(bits: xpressnet), data: []).canMTI)
        XCTAssertNil(CanFrame(header: CanHeader(bits: stream), data: []).canMTI)
    }

    func testDestinationAlias() {
        XCTAssertNil(CanFrame(header: CanHeader(bits: xpressnet), data: []).destinationAlias)
        XCTAssertEqual(0x820, CanFrame(header: CanHeader(bits: stream), data: []).destinationAlias)
    }

    func testSourceAlias() {
        XCTAssertEqual(0xFFF, CanFrame(header: CanHeader(bits: xpressnet), data: []).sourceAlias)
        XCTAssertEqual(0xFFF, CanFrame(header: CanHeader(bits: stream), data: []).sourceAlias)
    }
}
