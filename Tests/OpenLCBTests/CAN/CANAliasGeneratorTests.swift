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

class CANAliasGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPRNG_0x0() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x0))
        XCTAssertEqual(0x11E, prng.alias)
        XCTAssertEqual(0x1B0CA37A4BA9, prng.seed)
        XCTAssertEqual(1, prng.iterations)
        XCTAssertEqual(0x521, prng.nextAlias())
        XCTAssertEqual(0x4F603B8BE952, prng.seed)
        XCTAssertEqual(2, prng.iterations)
        XCTAssertEqual(0x42D, prng.nextAlias())
        XCTAssertEqual(0x2AE3F5D8D8FB, prng.seed)
        XCTAssertEqual(3, prng.iterations)
        XCTAssertEqual(0x663, prng.nextAlias())
        XCTAssertEqual(0x0DDC4B051AA4, prng.seed)
        XCTAssertEqual(4, prng.iterations)
    }

    func testPRNG_0x020121000012() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x020121000012))
        XCTAssertEqual(0x113, prng.alias)
        XCTAssertEqual(0x020121000012, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0x62D, prng.nextAlias())
        XCTAssertEqual(0x1F4FC47A6FBB, prng.seed)
        XCTAssertEqual(1, prng.iterations)
    }

    func testPRNG_0x020112000021() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x020112000021))
        XCTAssertEqual(0x113, prng.alias)
        XCTAssertEqual(0x020112000021, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0xA24, prng.nextAlias())
        XCTAssertEqual(0x1F31B57A8DCA, prng.seed)
        XCTAssertEqual(1, prng.iterations)
    }

    func testPRNG_0x020111000022() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x020111000022))
        XCTAssertEqual(0x113, prng.alias)
        XCTAssertEqual(0x020111000022, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0x625, prng.nextAlias())
        XCTAssertEqual(0x1F2FB47A8FCB, prng.seed)
        XCTAssertEqual(1, prng.iterations)
    }

    func testPRNG_0x020122000011() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x020122000011))
        XCTAssertEqual(0x113, prng.alias)
        XCTAssertEqual(0x020122000011, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0xA2C, prng.nextAlias())
        XCTAssertEqual(0x1F51C57A6DBA, prng.seed)
        XCTAssertEqual(1, prng.iterations)
    }

    func testPRNG_0x1234567890AB() {
        var prng = CANAliasGenerator(for: NodeId(value: 0x1234567890AB))
        XCTAssertEqual(0x257, prng.alias)
        XCTAssertEqual(0x1234567890AB, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0x7A2, prng.nextAlias())
        XCTAssertEqual(0x95EDEB143254, prng.seed)
        XCTAssertEqual(1, prng.iterations)
        prng.reset()
        XCTAssertEqual(0x257, prng.alias)
        XCTAssertEqual(0x1234567890AB, prng.seed)
        XCTAssertEqual(0, prng.iterations)
        XCTAssertEqual(0x7A2, prng.nextAlias())
        XCTAssertEqual(0x95EDEB143254, prng.seed)
        XCTAssertEqual(1, prng.iterations)
    }
}
