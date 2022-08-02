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

public extension MTI {

    /**
     Create an MTI from a CAN frame.

     If the CAN frame does not have an MTI, the result is ``nil``.

     - parameters:
     - frame: the CAN frame, which may or may not contain a MTI
     */
    init?(frame: CANFrame) {
        var mti: UInt16?
        if frame.isOpenLCBMessage {
            switch frame.type {
            case .globalAddressedMTI:
                mti = frame.CANMTI
            case .datagramCompleteInFrame, .datagramFirstFrame, .datagramMiddleFrame, .datagramFinalFrame:
                mti = CommonMTI.datagram.rawValue.rawValue
            case .streamData:
                mti = CommonMTI.streamDataSend.rawValue.rawValue
            default:
                break
            }
        }
        guard let mti = mti else { return nil }
        self.init(rawValue: mti)
    }
}
