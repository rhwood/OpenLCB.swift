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

    static func fromCanFrame(_ frame: CanFrame) -> MTI? {
        if frame.isOpenLCBMessage {
            switch frame.type {
            case 1:
                if let mti = frame.canMTI {
                    return MTI(value: mti)
                }
            case 2, 3, 4, 5:
                return CommonMTI.datagram.rawValue
            case 7:
                return CommonMTI.streamDataSend.rawValue
            default:
                break
            }
        }
        return nil
    }
}
