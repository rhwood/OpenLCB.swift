//
//  File.swift
//  
//
//  Created by Randall Wood on 6/23/22.
//

public protocol Message: CustomStringConvertible {

    var source: NodeId { get }

    var mti: CommonMTI { get }

    var description: String { get }

}

public extension Message {

    var description: String {
        "\(source.description) \(mti)"
    }

}
