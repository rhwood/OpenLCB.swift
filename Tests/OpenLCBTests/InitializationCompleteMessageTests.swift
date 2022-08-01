//
//  InitializationCompleteMessageTests.swift
//  
//
//  Created by Randall Wood on 8/1/22.
//

@testable import OpenLCB
import XCTest

class InitializationCompleteMessageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMessage() throws {
        let message = InitializationCompleteMessage(source: NodeId(value: 0x1234567890AB))
        XCTAssertEqual(NodeId(value: 0x1234567890AB), message.source)
        XCTAssertEqual(CommonMTI.initializationComplete.rawValue, message.mti)
        XCTAssertEqual("0x12.34.56.78.90.AB Initialization Complete", "\(message)")
    }

}
