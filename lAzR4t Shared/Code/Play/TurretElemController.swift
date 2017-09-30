//
//  TurretElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class TurretElemController: SimpleElemController<TurretElem> {
    override var curModel: TurretElem {
        didSet {
            node_spe.reconfigure(
                color: curModel.color,
                direction: curModel.direction,
                size: curModel.size
            )
        }
    }
    let node_spe: TurretElemNode
    
    init(curModel: TurretElem) {
        node_spe = TurretElemNode(
            color: curModel.color,
            direction: curModel.direction,
            size: curModel.size
        )
        super.init(curModel: curModel, node: node_spe)
    }
}
