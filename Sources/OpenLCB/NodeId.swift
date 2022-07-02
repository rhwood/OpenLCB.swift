//
//  File.swift
//  
//
//  Created by Randall Wood on 6/20/22.
//

public struct NodeId: Equatable, Hashable, RawRepresentable, CustomStringConvertible {
    public typealias RawValue = UInt64

    public enum NodeIDError: Error {
        case insufficentBytes
    }

    public let id: UInt64

    public var bytes: [UInt8] {
        Utilities.bytesFromInt(id).suffix(6)
    }
    
    public init(node: NodeId) {
        try! self.init(bytes: node.bytes)
    }

    public init() {
        self.init(value: 0)
    }
    
    public init(bytes: [UInt8]) throws {
        guard bytes.count >= 6 else { throw NodeIDError.insufficentBytes }
        self.init(value: Utilities.uInt64FromBytes(Array(bytes[..<6])))
    }

    public init(value: UInt64) {
        // no need to guard since bytesFromInt will provide a correct sized array
        self.id = value
    }
    
    public init(value: String) throws {
        try self.init(bytes: Utilities.bytesFromHexString(value))
    }

    public init?(rawValue: RawValue) {
        self.init(value: rawValue)
    }

    public var rawValue: RawValue {
        Utilities.uInt64FromBytes(bytes)
    }

    public var description: String {
        String(format: "%02X.%02X.%02X.%02X.%02X.%02X", arguments:bytes)
    }
}
