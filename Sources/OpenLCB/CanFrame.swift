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

public struct CanFrame {

    public let header: CanHeader

    public let data: [UInt8]

    public var prefix: UInt8 {
        header.prefix
    }

    public var type: UInt8 {
        header.type
    }

    public var isOpenLCBMessage: Bool {
        header.isOpenLCBMessage
    }

    public var isCANControlFrame: Bool {
        header.isCANControlFrame
    }

    public var canMTI: UInt16? {
        header.canMTI
    }

    public var destinationAlias: UInt16? {
        header.destinationAlias
    }

    public var sourceAlias: UInt16 {
        header.sourceAlias
    }
}
