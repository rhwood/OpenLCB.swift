//
//  File.swift
//  
//
//  Created by Randall Wood on 6/23/22.
//

public enum CommonMTI: UInt16, RawRepresentable, CustomStringConvertible {

    case initializationComplete = 0x0100
    case verifyNodeIDNumberAddressed = 0x0488
    case verifyNodeIDNumberGlobal = 0x0490
    case verifiedNodeIDNumber = 0x0170

    public var description: String {
        switch self {
        case .initializationComplete: return "Initialization Complete"
        case .verifyNodeIDNumberAddressed, .verifyNodeIDNumberGlobal: return "Verify Node ID Number"
        case .verifiedNodeIDNumber: return "Verified Node ID Number"
        }
    }
}
