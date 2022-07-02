public struct EventId: Equatable, Hashable, RawRepresentable, CustomStringConvertible {
    public typealias RawValue = UInt64
    
    public enum EventIDError: Error {
        case insufficientBytes
    }

    public let id: UInt64

    public var bytes: [UInt8] {
        Utilities.bytesFromInt(id)
    }

    public init(node: NodeId, suffix: UInt16) {
        self.init(value: Utilities.uInt64FromBytes(node.bytes + Utilities.bytesFromInt(suffix)))
    }

    public init(bytes: [UInt8]) throws {
        guard bytes.count == 8 else { throw EventIDError.insufficientBytes }
        self.init(value: Utilities.uInt64FromBytes(bytes))
    }
    
    public init(value: UInt64) {
        self.id = value
    }

    public init(value: String) throws {
        try self.init(bytes: Utilities.bytesFromHexString(value))
    }

    public init?(rawValue: RawValue) {
        self.init(value: rawValue)
    }

    public var nodeID: NodeId {
        try! NodeId(bytes: Array(self.bytes[..<6]))
    }

    public var suffix: UInt16 {
        UInt16(Utilities.intFromBytes(Array(self.bytes[6...7])))
    }

    public var rawValue: RawValue {
        Utilities.uInt64FromBytes(self.bytes)
    }

    public var description: String {
        String(format: "%02X.%02X.%02X.%02X.%02X.%02X.%02X.%02X", arguments:bytes)
    }
}
