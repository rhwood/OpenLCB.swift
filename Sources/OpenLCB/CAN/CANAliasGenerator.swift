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
 ``NodeId`` CAN alias generator based on the preferred pseudo random alias generation algorithm in
 [OpenLCB CAN Frame Transfer Technical Note](http://old.openlcb.org/trunk/specs/CanFrameTransferTN.pdf).
 */
struct CANAliasGenerator {

    private var upperHalf: UInt32 = 0
    private var lowerHalf: UInt32 = 0
    /**
     Node for which aliases are generated.
     */
    let id: NodeId

    /**
     Number of times the ``alias`` has been generated.
     */
    var iterations: Int = 0

    /**
     Generated alias.
     */
    var alias: UInt16 {
        UInt16((upperHalf ^ lowerHalf ^ (upperHalf >> 12) ^ (lowerHalf >> 12)) & 0xFFF)
    }

    /**
     Seed used to generate ``alias``.
     */
    var seed: UInt64 {
        (UInt64(upperHalf) << 24) | UInt64(lowerHalf)
    }

    /**
     Create a generator for a given node.

     - parameters:
     - for: the node to create this generator for
     */
    init(for id: NodeId) {
        self.id = id
        reset()
    }

    /**
     Generate the next alias for the node.

     - returns: the next alias; this can be later retrieved as ``alias``
     */
    mutating func nextAlias() -> UInt16 {
        _nextAlias()
        return alias
    }

    private mutating func _nextAlias() {
        repeat {
            // step the PRNG
            // First, form 2^9*val
            let temp1 = ((upperHalf << 9) | ((lowerHalf >> 15) & 0x1FF)) & 0xFFFFFF
            let temp2 = (lowerHalf << 9) & 0xFFFFFF

            // add
            lowerHalf += temp2 + 0x7A4BA9
            upperHalf += temp1 + 0x1B0CA3

            // carry
            upperHalf = (upperHalf & 0xFFFFFF) | ((lowerHalf & 0xFF000000) >> 24)
            lowerHalf = lowerHalf & 0xFFFFFF

            // increment iterations
            iterations += 1
        } while alias == 0
    }

    /**
     Reset the generator. An ``alias`` retrieved after reseting the generator are the same as the alias retrieved
     after creating a new generator for the same ``NodeId``.
     */
    mutating func reset() {
        upperHalf = UInt32((id.rawValue & 0xFFFFFF000000) >> 24)
        lowerHalf = UInt32(id.rawValue & 0xFFFFFF)
        iterations = 0
        if alias == 0 { _nextAlias() }
    }
}
