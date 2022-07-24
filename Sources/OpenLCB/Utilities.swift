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

import Foundation

struct Utilities {
    
    /// Create a [UInt8] from a number. This does not protect against count being incorrect.
    ///
    /// - returns:
    /// [UInt8] containing count elements
    ///
    /// - parameters:
    ///   - source: a number
    ///   - count: the number of bytes
    static public func bytes(_ source: UInt64, count: Int) -> [UInt8] {
        Array(0..<count).reversed().compactMap { index in
            UInt8((source >> (index * 8)) & 0xff)
        }
    }
    
    /// Create a [UInt8] from a fixed width number.
    ///
    /// - returns:
    /// [UInt8] containing the number of bits in the number type / 8 elements
    ///
    /// - parameters:
    ///   - source: a number
    static public func bytes<I: FixedWidthInteger>(_ source: I) -> [UInt8] {
        bytes(UInt64(source), count: I.bitWidth / 8)
    }

    /// Create a [UInt8] from a String containing hexadecimal values by tokenizing the source and
    /// converting each token into a UInt8. Non-convertable tokens are silently dropped.
    ///
    /// - returns:
    /// [UInt8] which may be empty
    ///
    /// - parameters:
    ///   - source: a String of hex values separated by either spaces or dots
    static public func bytes(_ source: String) -> [UInt8] {
        source
            .replacingOccurrences(of: ".", with: " ")
            .split(separator: " ")
            .compactMap { number in
                UInt8(number)
            }
    }

    /// Creates an Int from a [UInt8].
    ///
    /// - returns:
    /// A number
    ///
    /// - parameters:
    ///   - source: an array of UInt8; uses last 8 elements if source.count > 8
    static public func intFromBytes(_ source: [UInt8]) -> Int {
        // does not share code with uInt64FromBytes because Int
        // does not convert to/from UInt64 if first bit is 1
        source.reduce(0) { value, byte in
            (value << 8) | Int(byte)
        }
    }

    /// Creates an UInt64 from a [UInt8].
    ///
    /// - returns:
    /// A number
    ///
    /// - parameters:
    ///   - source: an array of UInt8; uses last 8 elements if source.count > 8
    static public func uInt64FromBytes(_ source: [UInt8]) -> UInt64 {
        // does not share code with intFromBytes because Int
        // does not convert to/from UInt64 if first bit is 1
        source.reduce(0) { value, byte in
            (value << 8) | UInt64(byte)
        }
    }

    /// Create an array of Bits from a fixed width integer.
    ///
    /// - returns:
    /// An array of Bits
    ///
    /// - parameters:
    ///   - bytes: the integer to get bits from
    static public func bits<T: FixedWidthInteger>(_ bytes: T) -> [Bit] {
        bytes.bits
    }

    /// Create a String of bytes separated by spaces.
    ///
    /// - returns:
    /// A printable string of bytes with consistent formatting
    ///
    /// - parameters:
    ///   - bytes: the array of bytes to print
    static public func byteString<I: FixedWidthInteger>(_ bytes: I) -> String {
        byteString(Utilities.bytes(bytes))
    }

    /// Create a String of bytes separated by spaces.
    ///
    /// - returns:
    /// A printable string of bytes with consistent formatting
    ///
    /// - parameters:
    ///   - bytes: the array of bytes to print
    static public func byteString(_ bytes: [UInt8]) -> String {
        bytes.map { String(format: "%02X", $0 ) }.joined(separator: ".")
    }
}

// source: https://stackoverflow.com/a/51770616
public enum Bit: UInt8, CustomStringConvertible {
    case zero, one

    public var description: String {
        switch self {
        case .one:
            return "1"
        case .zero:
            return "0"
        }
    }
}

/// Lazily compute, but not recompute, a var in a struct
// source: https://stackoverflow.com/a/51734402
class LazyVar<Object, Property> {
    let block:(Object)->Property
    private var cache:Property? = nil

    init(_ block:@escaping (Object)->Property) {
        self.block = block
    }

    func lazy(_ input:Object) -> Property {
        if self.cache == nil {
            self.cache = self.block(input)
        }
        return self.cache!
    }
}

// source: https://stackoverflow.com/a/51770616
extension FixedWidthInteger {
    var bits: [Bit] {
        var bytes = self
        // Fill an array of bits with zeros to the fixed width integer length
        var bits = [Bit](repeating: .zero, count: self.bitWidth)
        // Run through each bit (LSB first)
        for i in 0..<self.bitWidth {
            let currentBit = bytes & 0x01
            if currentBit != 0 {
                bits[i] = .one
            }
            bytes >>= 1
        }
        return bits
    }
}
