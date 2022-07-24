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

public struct NodeId: Equatable, Hashable, RawRepresentable, CustomStringConvertible {
    public typealias RawValue = UInt64

    public enum NodeIDError: Error {
        case insufficentBytes
    }

    public let id: UInt64

    public var bytes: [UInt8] {
        Utilities.bytes(id).suffix(6)
    }

    public init(node: NodeId) {
        // Force try to avoid caller needing to use in try...catch block
        // since this call is known to succeed
        // swiftlint:disable force_try
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
        try self.init(bytes: Utilities.bytes(value))
    }

    public init?(rawValue: RawValue) {
        self.init(value: rawValue)
    }

    public var rawValue: RawValue {
        Utilities.uInt64FromBytes(bytes)
    }

    public var description: String {
        Utilities.byteString(bytes)
    }
}
