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

public enum CommonMTI: MTI, RawRepresentable, CustomStringConvertible {

    // Defined in OpenLCB Message Network Standard
    // Basic
    case initializationComplete = 0x0100
    // swiftlint thinks next name is too long
    // swiftlint:disable identifier_name
    case initializationCompleteSimpleSetSufficient = 0x0101
    case verifyNodeIDNumberAddressed = 0x0488
    case verifyNodeIDNumberGlobal = 0x0490
    case verifiedNodeIDNumber = 0x0170
    case verifiedNodeIDNumberSimpleSetSufficient = 0x0171
    case optionalInteractionRejected = 0x0068
    case terminateDueToError = 0x00A8
    // Protocol Support
    case protocolSupportInquiry = 0x0828
    case protocolSupportReply = 0x0668
    // Defined in ???
    // Event Exchange
    case identifyConsumer = 0x08F4
    case consumerRangeIdentified = 0x04A4
    case consumerIdentifiedValidityUnknown = 0x04C7
    case consumerIdentifiedAsCurrentlyValid = 0x04C4
    case consumerIdentifiedAsCurrentlyInvalid = 0x04C5
    case consumerIdentifiedReserved = 0x04C6
    case identifyProducer = 0x0914
    case producerRangeIdentified = 0x0524
    case producerIdentifiedValidityUnknown = 0x0547
    case producerIdentifiedAsCurrentlyValid = 0x0544
    case producerIdentifiedAsCurrentlyInvalid = 0x0545
    case producerIdentifiedReserved = 0x0546
    case identifyEventsAddressed = 0x0968
    case identifyEventsGlobal = 0x0970
    case learnEvent = 0x0594
    case producerConsumerEventReport = 0x05B4
    // Defined in ???
    // Traction Control
    case tractionControlCommand = 0x05EB
    case tractionControlReply = 0x01E9
    case tractionProxyCommand = 0x05EA
    case tractionProxyReply = 0x01E8
    // Defined in ???
    // Other
    case xpressnet = 0x0820
    // Defined in ???
    // Remote Button
    case remoteButtonRequest = 0x0948
    case remoteButtonReply = 0x0549
    // Defined in ???
    // Traction Ident
    case simpleTrainNodeIdentInfoRequest = 0x0DA8
    case simpleTrainNodeIdentInfoReply = 0x09C8
    // Defined in ???
    // Node Ident
    case simpleNodeIdentInfoRequest = 0x0DE8
    case simpleNodeIdentInfoReply = 0x0A08
    // Defined in ???
    // Datagram
    case datagram = 0x1C48
    case datagramReceivedOK = 0x0A28
    case datagramRejected = 0x0A48
    // Degined in ???
    // Stream
    case streamInitiateRequest = 0x0CC8
    case streamInitiateReply = 0x0868
    case streamDataSend = 0x1F88
    case streamDataProceed = 0x0888
    case streamDataComplete = 0x08A8
    // Defined in ???
    // Extra
    case nodeNumberAllocate = 0x2000
    case noFiltering = 0x2020

    public var description: String {
        switch self {
        case .initializationComplete, .initializationCompleteSimpleSetSufficient: return "Initialization Complete"
        case .verifyNodeIDNumberAddressed, .verifyNodeIDNumberGlobal: return "Verify Node ID Number"
        case .verifiedNodeIDNumber, .verifiedNodeIDNumberSimpleSetSufficient: return "Verified Node ID Number"
        case .optionalInteractionRejected: return "Optional Interaction Rejected"
        case .terminateDueToError: return "Terminate Due to Error"
        case .protocolSupportInquiry: return "Protocol Support Inquiry"
        case .protocolSupportReply: return "Protocol Support Reply"
        case .identifyConsumer: return "Identify Consumer"
        case .consumerRangeIdentified: return "Consumer Range Identified"
        case .consumerIdentifiedValidityUnknown: return "Consumer Identified w/ Validity Unknown"
        case .consumerIdentifiedAsCurrentlyValid: return "Consumer Identified As Currently Valid"
        case .consumerIdentifiedAsCurrentlyInvalid: return "Consumer Identified As Currently Invalid"
        case .consumerIdentifiedReserved: return "Consumer Identified (reserved)"
        case .identifyProducer: return "Identify Producer"
        case .producerRangeIdentified: return "Producer Range Identified"
        case .producerIdentifiedValidityUnknown: return "Producer Identified w/ Validity Unknown"
        case .producerIdentifiedAsCurrentlyValid: return "Producer Identified As Currently Valid"
        case .producerIdentifiedAsCurrentlyInvalid: return "Producer Identified As Currently Invalid"
        case .producerIdentifiedReserved: return "Producer Identified (reserved)"
        case .identifyEventsAddressed: return "Identify Events Addressed"
        case .identifyEventsGlobal: return "Identify Events Global"
        case .learnEvent: return "Learn Event"
        case .producerConsumerEventReport: return "Producer/Consumer Event Report"
        case .tractionControlCommand: return "Traction Control Command"
        case .tractionControlReply: return "Traction Control Reply"
        case .tractionProxyCommand: return "Traction Proxy Command"
        case .tractionProxyReply: return "Traction Proxy Reply"
        case .xpressnet: return "Xpressnet"
        case .remoteButtonRequest: return "Remote Button Request"
        case .remoteButtonReply: return "Remote Button Reply"
        case .simpleTrainNodeIdentInfoRequest: return "Simple Train Node Ident Info Request"
        case .simpleTrainNodeIdentInfoReply: return "Simple Train Node Ident Info Reply"
        case .simpleNodeIdentInfoRequest: return "Simple Node Ident Info Request"
        case .simpleNodeIdentInfoReply: return "Simple Node Ident Info Reply"
        case .datagram: return "Datagram"
        case .datagramReceivedOK: return "Datagram Received OK"
        case .datagramRejected: return "Datagram Rejected"
        case .streamInitiateRequest: return "Stream Initiate Request"
        case .streamInitiateReply: return "Stream Initiate Reply"
        case .streamDataSend: return "Stream Data Send"
        case .streamDataProceed: return "Stream Data Proceed"
        case .streamDataComplete: return "Stream Data Complete"
        case .nodeNumberAllocate: return "Node Number Allocate"
        case .noFiltering: return "No Filtering"
        }
    }
}
