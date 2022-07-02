//
//  File 2.swift
//  
//
//  Created by Randall Wood on 6/20/22.
//

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
    static public func bytesFromInt(_ source: UInt64, count: Int) -> [UInt8] {
        Array(0..<count).reversed().compactMap { index in
            UInt8((source >> (index * 8)) & 0xff)
        }
    }
    
    /// Create a [UInt8] from a 8 byte number.
    ///
    /// - returns:
    /// [UInt8] containing 8 elements
    ///
    /// - parameters:
    ///   - source: a number
    static public func bytesFromInt(_ source: UInt64) -> [UInt8] {
        bytesFromInt(source, count: 8)
    }

    /// Create a [UInt8] from a 2 byte number.
    ///
    /// - returns:
    /// [UInt8] containing 2 elements
    ///
    /// - parameters:
    ///   - source: a number
    static public func bytesFromInt(_ source: UInt16) -> [UInt8] {
        bytesFromInt(UInt64(source), count: 2)
    }

    /// Create a [UInt8] from a String containing hexadecimal values by tokenizing the source and converting each token into a UInt8. Non-convertable tokens are silently dropped.
    ///
    /// - returns:
    /// [UInt8] which may be empty
    ///
    /// - parameters:
    ///   - source: a String of hex values separated by either spaces or dots
    static public func bytesFromHexString(_ source: String) -> [UInt8] {
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
}
 
