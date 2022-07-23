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

class CommonMTITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // when adding new cases, search for the regex 'case (.*): return "(.*)"' and
    // replace it with 'XCTAssertEqual("$2", "\\(CommonMTI$1)")' (be careful to ensure this comment
    // is not changed when running regex)
    func testDescription() throws {
        XCTAssertEqual("Initialization Complete", "\(CommonMTI.initializationComplete)")
        XCTAssertEqual("Initialization Complete", "\(CommonMTI.initializationCompleteSimpleSetSufficient)")
        XCTAssertEqual("Verify Node ID Number", "\(CommonMTI.verifyNodeIDNumberAddressed)")
        XCTAssertEqual("Verify Node ID Number", "\(CommonMTI.verifyNodeIDNumberGlobal)")
        XCTAssertEqual("Verified Node ID Number", "\(CommonMTI.verifiedNodeIDNumber)")
        XCTAssertEqual("Optional Interaction Rejected", "\(CommonMTI.optionalInteractionRejected)")
        XCTAssertEqual("Terminate Due to Error", "\(CommonMTI.terminateDueToError)")
        XCTAssertEqual("Protocol Support Inquiry", "\(CommonMTI.protocolSupportInquiry)")
        XCTAssertEqual("Protocol Support Reply", "\(CommonMTI.protocolSupportReply)")
        XCTAssertEqual("Identify Consumer", "\(CommonMTI.identifyConsumer)")
        XCTAssertEqual("Consumer Range Identified", "\(CommonMTI.consumerRangeIdentified)")
        XCTAssertEqual("Consumer Identified w/ Validity Unknown", "\(CommonMTI.consumerIdentifiedValidityUnknown)")
        XCTAssertEqual("Consumer Identified As Currently Valid", "\(CommonMTI.consumerIdentifiedAsCurrentlyValid)")
        XCTAssertEqual("Consumer Identified As Currently Invalid", "\(CommonMTI.consumerIdentifiedAsCurrentlyInvalid)")
        XCTAssertEqual("Consumer Identified (reserved)", "\(CommonMTI.consumerIdentifiedReserved)")
        XCTAssertEqual("Identify Producer", "\(CommonMTI.identifyProducer)")
        XCTAssertEqual("Producer Range Identified", "\(CommonMTI.producerRangeIdentified)")
        XCTAssertEqual("Producer Identified w/ Validity Unknown", "\(CommonMTI.producerIdentifiedValidityUnknown)")
        XCTAssertEqual("Producer Identified As Currently Valid", "\(CommonMTI.producerIdentifiedAsCurrentlyValid)")
        XCTAssertEqual("Producer Identified As Currently Invalid", "\(CommonMTI.producerIdentifiedAsCurrentlyInvalid)")
        XCTAssertEqual("Producer Identified (reserved)", "\(CommonMTI.producerIdentifiedReserved)")
        XCTAssertEqual("Identify Events Addressed", "\(CommonMTI.identifyEventsAddressed)")
        XCTAssertEqual("Identify Events Global", "\(CommonMTI.identifyEventsGlobal)")
        XCTAssertEqual("Learn Event", "\(CommonMTI.learnEvent)")
        XCTAssertEqual("Producer/Consumer Event Report", "\(CommonMTI.producerConsumerEventReport)")
        XCTAssertEqual("Traction Control Command", "\(CommonMTI.tractionControlCommand)")
        XCTAssertEqual("Traction Control Reply", "\(CommonMTI.tractionControlReply)")
        XCTAssertEqual("Traction Proxy Command", "\(CommonMTI.tractionProxyCommand)")
        XCTAssertEqual("Traction Proxy Reply", "\(CommonMTI.tractionProxyReply)")
        XCTAssertEqual("Xpressnet", "\(CommonMTI.xpressnet)")
        XCTAssertEqual("Remote Button Request", "\(CommonMTI.remoteButtonRequest)")
        XCTAssertEqual("Remote Button Reply", "\(CommonMTI.remoteButtonReply)")
        XCTAssertEqual("Simple Train Node Ident Info Request", "\(CommonMTI.simpleTrainNodeIdentInfoRequest)")
        XCTAssertEqual("Simple Train Node Ident Info Reply", "\(CommonMTI.simpleTrainNodeIdentInfoReply)")
        XCTAssertEqual("Simple Node Ident Info Request", "\(CommonMTI.simpleNodeIdentInfoRequest)")
        XCTAssertEqual("Simple Node Ident Info Reply", "\(CommonMTI.simpleNodeIdentInfoReply)")
        XCTAssertEqual("Datagram", "\(CommonMTI.datagram)")
        XCTAssertEqual("Datagram Received OK", "\(CommonMTI.datagramReceivedOK)")
        XCTAssertEqual("Datagram Rejected", "\(CommonMTI.datagramRejected)")
        XCTAssertEqual("Stream Initiate Request", "\(CommonMTI.streamInitiateRequest)")
        XCTAssertEqual("Stream Initiate Reply", "\(CommonMTI.streamInitiateReply)")
        XCTAssertEqual("Stream Data Send", "\(CommonMTI.streamDataSend)")
        XCTAssertEqual("Stream Data Proceed", "\(CommonMTI.streamDataProceed)")
        XCTAssertEqual("Stream Data Complete", "\(CommonMTI.streamDataComplete)")
        XCTAssertEqual("Node Number Allocate", "\(CommonMTI.nodeNumberAllocate)")
        XCTAssertEqual("No Filtering", "\(CommonMTI.noFiltering)")
    }
    
}
