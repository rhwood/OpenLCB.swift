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

/**
 A CAN Frame with OpenLCB-specific details.
 */
public struct CanFrame {

    /**
     The CAN header. Do not rely on this being availble in future versions of this library.
     */
    public let header: CanHeader

    /**
     CAN frame data payload. Nil if the frame had no payload.
     */
    public let data: [UInt8]?

    /**
     CAN frame prefix (first 2 bits in header).
     */
    public var prefix: UInt8 {
        header.prefix
    }

    /**
     Type of message. This is likely to change to an enum of types.
     */
    public var type: UInt8 {
        header.type
    }

    /**
     True if the frame is an OpenLCB message; false otherwise.

     Always the opposite of ``isCANControlFrame``
     */
    public var isOpenLCBMessage: Bool {
        header.isOpenLCBMessage
    }

    /**
     True if the frame is a CAN control message; false otherwise.

     Always the opposite of ``isOpenLCBMessage``
     */
    public var isCANControlFrame: Bool {
        header.isCANControlFrame
    }

    /**
     The MTI within the CAN frame. Nil if there is no MTI. Convert to a full MTI using ``MTI/fromCanFrame(_:)``.
     */
    public var canMTI: UInt16? {
        header.canMTI
    }

    /**
     The destination alias in the frame. Nil if there is none.
     */
    public var destinationAlias: UInt16? {
        header.destinationAlias
    }

    /**
     The source alias in the frame.
     */
    public var sourceAlias: UInt16 {
        header.sourceAlias
    }
}
