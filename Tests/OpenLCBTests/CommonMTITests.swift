//
//  CommonMTITests.swift
//  
//
//  Created by Randall Wood on 6/27/22.
//

@testable import OpenLCB
import XCTest

class CommonMTITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDescription() throws {
        XCTAssertEqual("Initialization Complete", "\(CommonMTI.initializationComplete)")
    }

}
