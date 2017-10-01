//
//  HeartElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class HeartElemController: PlayElemController_impl<HeartElem> {
    override var curModel: HeartElem {
        didSet {
            node_spe.reconfigure(
                healthRatio: curModel.healthRatio,
                direction: curModel.direction,
                cellFrame: curModel.frame
            )
        }
    }
    let node_spe: HeartElemNode
    
    init(curModel: HeartElem) {
        node_spe = HeartElemNode(
            healthRatio: curModel.healthRatio,
            direction: curModel.direction,
            cellFrame: curModel.frame
        )
        super.init(curModel: curModel, node: node_spe)
    }
}
