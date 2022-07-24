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

public struct MTI: RawRepresentable, Equatable, CustomStringConvertible {
    public typealias RawValue = UInt16

    public let rawValue: UInt16
    private let _bits: LazyVar<MTI, [Bit]> = LazyVar { mti in
        Utilities.bits(mti.rawValue)
    }
    var bits: [Bit] {
        _bits.lazy(self)
    }

    public init(value: UInt16) {
        rawValue = value
    }

    public init?(rawValue: UInt16) {
        self.init(value: rawValue)
    }

    public var special: Bool {
        bits[13] == .one
    }

    public var streamOrDatagram: Bool {
        bits[12] == .one
    }

    public var priority: UInt8 {
        twoBits(left: 11, right: 10)
    }

    public var type: UInt8 {
        (bits[9].rawValue * 16) + (twoBits(left: 8, right: 7) * 4) + twoBits(left: 6, right: 5)
    }

    public var simpleProtocol: Bool {
        bits[4] == .one
    }

    public var addressPresent: Bool {
        bits[3] == .one
    }

    public var eventPresent: Bool {
        bits[2] == .one
    }

    public var modifier: UInt8 {
        twoBits(left: 1, right: 0)
    }

    public var description: String {
        if let cmti = CommonMTI(rawValue: self) {
            return cmti.description
        }
        return "Unknown MTI: \(Utilities.byteString(rawValue))"
    }

    private func twoBits(left: Int, right: Int) -> UInt8 {
        (bits[left].rawValue * 2) + bits[right].rawValue
    }
}

extension MTI: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value: UInt16(value))
    }
}
