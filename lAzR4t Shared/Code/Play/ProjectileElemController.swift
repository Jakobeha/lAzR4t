//
//  ProjectileElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ProjectileElemController: SimpleElemController<ProjectileElem> {
    override var curModel: ProjectileElem {
        didSet {
            node_spe.reconfigure(
                colors: curModel.colors,
                direction: curModel.direction,
                size: curModel.size
            )
        }
    }
    let node_spe: ProjectileElemNode
    
    init(curModel: ProjectileElem) {
        node_spe = ProjectileElemNode(
            colors: curModel.colors,
            direction: curModel.direction,
            size: curModel.size
        )
        super.init(curModel: curModel, node: node_spe)
    }
}
