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

    case initializationCompleteFullProtocolRequired = 0x0100
    case initializationCompleteSimpleSetSufficient = 0x0101
    case verifyNodeIDNumberAddressed = 0x0488
    case verifyNodeIDNumberGlobal = 0x0490
    case verifiedNodeIDNumber = 0x0170

    public var description: String {
        switch self {
        case .initializationCompleteFullProtocolRequired, .initializationCompleteSimpleSetSufficient: return "Initialization Complete"
        case .verifyNodeIDNumberAddressed, .verifyNodeIDNumberGlobal: return "Verify Node ID Number"
        case .verifiedNodeIDNumber: return "Verified Node ID Number"
        }
    }
}
