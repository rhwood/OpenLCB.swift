//
//  File.swift
//  
//
//  Created by Randall Wood on 6/26/22.
//

struct InitializationCompleteMessage: Message {

    let source: NodeId

    let mti: CommonMTI

    init(source: NodeId) {
        self.source = source
        self.mti = CommonMTI.initializationComplete
    }
}
