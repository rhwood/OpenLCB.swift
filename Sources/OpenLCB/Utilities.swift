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

// source: https://stackoverflow.com/a/51770616
public enum Bit: UInt8, CustomStringConvertible {
    case zero = 0
    case one = 1

    public var description: String {
        self == .one ? "1" : "0"
    }
}

extension Array where Element == Bit {

    /// Get a nibble from an arbitrary position in a [Bit]
    ///
    /// - returns:
    /// A UInt8 representing the nibble
    ///
    /// - parameters:
    ///   - index: The index of the first bit in the nibble
    public func nibble(_ index: Int) -> UInt8 {
        integer(start: index, end: index + 3)
    }

    /// Get a byte from an arbitrary position in a [Bit]
    ///
    /// - returns:
    /// A UInt8 representing the byte
    ///
    /// - parameters:
    ///   - index: The index of the first bit in the byte
    public func byte(_ index: Int) -> UInt8 {
        integer(start: index, end: index + 7)
    }

    /// Get a number for the bits between two indexes in a [Bit]
    ///
    /// - returns:
    /// An integer representing the bits
    ///
    /// - parameters:
    ///   - start: The index of the first bit in the number
    ///   - end: The index of the last bit in the number
    public func integer<I: FixedWidthInteger>(start: Int, end: Int) -> I {
        return self[start...end].reversed().reduce(0, { accumulated, current in
            accumulated << 1 | I(current.rawValue)
        })
    }
}

extension Array where Element == UInt8 {

    /**
     Create a String of bytes separated by spaces.

     OpenLCB conventions use a space (" ") to separate bytes in a stream, and periods (".") to
     separate bytes in a single value.

     - parameters:
     - separator: the characters to separate the bytes; defaults to a single period if not specified
     - returns:
     A printable string of bytes with consistent formatting
     */
    public func byteString(separator: String = ".") -> String {
        "0x" + self.map { String(format: "%02X", $0 ) }.joined(separator: separator)
    }
}

/// Lazily compute, but not recompute, a var in a struct
// source: https://stackoverflow.com/a/51734402
class LazyVar<Object, Property> {
    let block: (Object) -> Property
    private var cache: Property?

    init(_ block: @escaping (Object) -> Property) {
        self.block = block
    }

    func lazy(_ input: Object) -> Property {
        if self.cache == nil {
            self.cache = self.block(input)
        }
        return self.cache!
    }
}

// source: https://stackoverflow.com/a/51770616
extension FixedWidthInteger {
    /// An array of Bits representing the fixed width integer. The least significant bit is at index 0.
    public var bits: [Bit] {
        var bytes = self
        // Fill an array of bits with zeros to the fixed width integer length
        var bits = [Bit](repeating: .zero, count: self.bitWidth)
        // Run through each bit (LSB first)
        for index in 0..<self.bitWidth {
            if (bytes & 0x01) != 0 {
                bits[index] = .one
            }
            bytes >>= 1
        }
        return bits
    }
}

extension FixedWidthInteger {
    /**
     Creates an number from an array of bytes.

     - note: Uses last N elements of source where N is the bitwidth of the result

     - parameters:
     - bytes: byte array
     - returns: an integer
     */
    static public func fromBytes<I: FixedWidthInteger>(_ bytes: [UInt8]) -> I {
        bytes.reduce(0) { value, byte in
            (value << 8) | I(byte)
        }
    }

    /**
     Create a [UInt8] from a number. This does not protect against count being incorrect.

     - parameters:
     - count: the number of bytes; defaults to bitWidth of number
     - returns: [UInt8] containing count elements
     */
    public func bytes(count: Int = 0) -> [UInt8] {
        let source = self
        let count = count == 0 ? type(of: self).bitWidth / 8 : count
        return Array(0..<count).reversed().compactMap { index in
            UInt8((source >> (index * 8)) & 0xff)
        }
    }

    /**
     Create a String of bytes separated by spaces.

     OpenLCB conventions use a space (" ") to separate bytes in a stream, and periods (".") to
     separate bytes in a single value.
     - parameters:
     - separator: the characters to separate the bytes; defaults to a single period if not specified
     - returns:
     A printable string of bytes with consistent formatting
     */
    public func byteString(separator: String = ".") -> String {
        self.bytes().byteString(separator: separator)
    }
}

extension String {

    /**
     Create a [UInt8] from a String containing hexadecimal values by tokenizing the source and
     converting each token into a UInt8. Non-convertable tokens are silently dropped.

     - returns: [UInt8] which may be empty
     */
    public var bytes: [UInt8] {
        self
            .replacingOccurrences(of: ".", with: " ")
            .split(separator: " ")
            .compactMap { number in
                UInt8(number)
            }
    }

}
