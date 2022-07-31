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

// Right now I am ambivalent about needing this class, or if needed,
// exposing it outside the library (i.e., if needed to keep some complexity
// or inhertance issues out of CanFrame, should it be just an internal
// implementation detail?)
public struct CanHeader {

    public let bits: [Bit]

    public var prefix: UInt8 {
        bits.integer(start: 27, end: 28)
    }

    public var variable: [Bit] {
        Array(bits[12...26])
    }

    public var type: CanFrame.FrameType {
        CanFrame.FrameType(rawValue: bits.integer(start: 24, end: 26)) ?? .globalAddressedMTI
    }

    public var isOpenLCBMessage: Bool {
        bits[27] == .one
    }

    public var isCANControlFrame: Bool {
        !isOpenLCBMessage
    }

    public var canMTI: UInt16? {
        if type == .globalAddressedMTI {
            return bits.integer(start: 12, end: 23)
        }
        return nil
    }

    public var destinationAlias: UInt16? {
        switch type {
        case .datagramCompleteInFrame, .datagramFirstFrame, .datagramMiddleFrame, .datagramFinalFrame, .streamData:
            return bits.integer(start: 12, end: 23)
        default:
            return nil
        }
    }

    public var sourceAlias: UInt16 {
        return bits.integer(start: 0, end: 11)
    }
}
