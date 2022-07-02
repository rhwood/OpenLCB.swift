//
//  AddressedMessage.swift
//  
//
//  Created by Randall Wood on 6/26/22.
//

public protocol AddressedMessage: Message {

    var destination: NodeId { get }
}
