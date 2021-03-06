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

import XCTest
import OpenLCB

class WellKnownEventTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testId() throws {
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0xFF, 0xFF], WellKnownEvent.emergencyOff.id.bytes)
    }

    func testIsWellKnown() throws {
        XCTAssertTrue(WellKnownEvent.isWellKnown(WellKnownEvent.emergencyOff.id))
        XCTAssertTrue(WellKnownEvent.isWellKnown(EventId(value: 0xFFFF)))
        XCTAssertFalse(WellKnownEvent.isWellKnown(EventId(value: 0xFFFFFFFFFFFFFFFF)))
    }

    func testDescription() {
        XCTAssertEqual("0x00.00.00.00.00.00.FF.FF", "\(WellKnownEvent.emergencyOff)")
        XCTAssertEqual("0x01.01.00.00.00.00.02.01", "\(WellKnownEvent.duplicateNodeId)")
    }
}
