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

public struct EventId: Equatable, Hashable, RawRepresentable, CustomStringConvertible {
    public typealias RawValue = UInt64

    public enum EventIDError: Error {
        case incorrectByteCount
    }

    public let id: UInt64

    public var bytes: [UInt8] {
        id.bytes()
    }

    public init(node: NodeId, suffix: UInt16) {
        self.init(value: UInt64(bytes: node.bytes + suffix.bytes()))
    }

    public init(bytes: [UInt8]) throws {
        guard bytes.count == 8 else { throw EventIDError.incorrectByteCount }
        self.init(value: UInt64(bytes: bytes))
    }

    public init(value: UInt64) {
        self.id = value
    }

    public init(value: String) throws {
        try self.init(bytes: value.bytes)
    }

    public init?(rawValue: RawValue) {
        self.init(value: rawValue)
    }

    public var nodeID: NodeId {
        // Force try to avoid caller needing to use in try...catch block
        // since this call is known to succeed
        // swiftlint:disable:next force_try
        try! NodeId(bytes: Array(self.bytes[..<6]))
    }

    public var suffix: UInt16 {
        UInt16(bytes: Array(self.bytes[6...7]))
    }

    public var rawValue: RawValue {
        self.id
    }

    public var description: String {
        id.byteString()
    }
}
