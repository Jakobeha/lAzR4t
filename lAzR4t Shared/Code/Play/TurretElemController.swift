//
//  TurretElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class TurretElemController: PlayElemController_impl<TurretElem> {
    override var curModel: TurretElem {
        didSet {
            node_spe.reconfigure(
                healthRatio: curModel.healthRatio,
                color: curModel.color,
                direction: curModel.direction,
                isPlaceholder: curModel.isPlaceholder,
                pos: curModel.pos
            )
        }
    }
    let node_spe: TurretElemNode
    var color: AttackColor {
        get { return curModel.color }
        set(newColor) { curModel = curModel.set(color: newColor) }
    }
    var direction: CellDirection {
        get { return self.curModel.direction }
        set(newDirection) { curModel = curModel.set(direction: newDirection) }
    }
    var isPlaceholder: Bool {
        get { return curModel.isPlaceholder }
        set(newIsPlaceholder) { curModel = curModel.set(isPlaceholder: newIsPlaceholder) }
    }
    var pos: CellPos {
        get { return curModel.pos }
        set(newPos) { curModel = curModel.set(pos: newPos) }
    }
    
    init(curModel: TurretElem) {
        node_spe = TurretElemNode(
            healthRatio: curModel.healthRatio,
            color: curModel.color,
            direction: curModel.direction,
            isPlaceholder: curModel.isPlaceholder,
            pos: curModel.pos
        )
        super.init(curModel: curModel, node: node_spe)
    }
}
