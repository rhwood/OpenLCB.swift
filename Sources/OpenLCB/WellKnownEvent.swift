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

public enum WellKnownEvent: UInt64, CaseIterable, CustomStringConvertible {
    public typealias RawValue = UInt64

    // Well-known automatically routed event IDs
    case emergencyOff = 0x0000000000FFFF
    case clearEmergencyOff = 0x010000000000FFFE
    case emergencyStop = 0x010000000000FFFD
    case clearEmergencyStop = 0x010000000000FFFC
    case newLogEntry = 0x010000000000FFF8
    case identButtonPressed = 0x010000000000FE00
    case linkError1 = 0x010000000000FD01
    case linkError2 = 0x010000000000FD02
    case linkError3 = 0x010000000000FD03
    case linkError4 = 0x010000000000FD04

    // Well-known event IDs

    case duplicateNodeId = 0x0101000000000201
    case isTrain = 0x0101000000000303
    case isTractionProxy = 0x0101000000000304

    public var id: EventId {
        EventId(value: self.rawValue)
    }

    public static func isWellKnown(_ id: EventId) -> Bool {
        WellKnownEvent.allCases.map({ event in
            event.rawValue
        }).contains(id.rawValue)
    }

    public var description: String {
        self.id.description
    }
}
