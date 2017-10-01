//
//  ProjectileElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ProjectileElemController: PlayElemController_impl<ProjectileElem> {
    override var curModel: ProjectileElem {
        didSet {
            node_spe.reconfigure(
                colors: curModel.colors,
                direction: curModel.direction,
                pos: curModel.pos,
                offset: self.displayOffset
            )
        }
    }
    let node_spe: ProjectileElemNode
    var pos: CellPos {
        get { return curModel.pos }
        set(newPos) { curModel = curModel.set(pos: newPos) }
    }
    var direction: CellDirection {
        get { return curModel.direction }
    }
    var _displayOffset: CGFloat
    ///A display offset which shows this projectile;'s progress to the next cell
    var displayOffset: CGFloat {
        get { return _displayOffset }
        set(newDisplayOffset) {
            _displayOffset = newDisplayOffset
            node_spe.reconfigure(
                direction: curModel.direction,
                pos: curModel.pos,
                offset: self.displayOffset
            )
        }
    }
    
    init(curModel: ProjectileElem) {
        _displayOffset = 0
        node_spe = ProjectileElemNode(
            colors: curModel.colors,
            direction: curModel.direction,
            pos: curModel.pos,
            offset: _displayOffset
        )
        super.init(curModel: curModel, node: node_spe)
    }
    
    func moveOneUnit(affecting collidables: [PlayElemController]) {
        assert(isInPlay, "Projectile shouldn't be moved when it's out of play")
        
        let newPos = pos + direction.unitOffset
        let collideds = collidables.filter { $0.curModel_play.frame.contains(center: newPos) }
        
        var shouldRemove = false
        for collided in collideds {
            collided.absorb(projectile: curModel)
            if let collidedProj = collided.curModel_play as? ProjectileElem {
                //A projectile doesn't need to be removed when it collides with other projectiles,
                //but it still could be removed in `absorb`
                absorb(projectile: collidedProj)
            } else {
                //A projectile is removed when it collides with a non-projectile.
                shouldRemove = true
            }
        }
        if shouldRemove && isInPlay {
            removeFromPlay()
        }
        pos = newPos
    }
}
