//
//  PlayerController.swift
//  lAzR4t iOS
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Controls all of a player's stuff: turrets, actions, etc.
class PlayerController {
    let direction: PlayerDirection
    let turretField: GridElemController<TurretElem>
    var turretGrid: GridController<TurretElem> { return turretField.grid }
    var _turrets: List<TurretElemController> = List.empty
    var turrets: List<TurretElemController> {
        //Removes destroyed turrets
        _turrets = _turrets.filter { $0.isInPlay }
        return _turrets
    }
    let heart: HeartElemController
    var curModel: PlayerModel {
        return PlayerModel(direction: self.direction, turretField: self.turretField.curModel, heart: self.heart.curModel)
    }
    ///The player's turrets, in the model's own scope, not their local field.
    var globalTurrets: [PlayElemController] {
        return turrets.toArray.map { $0.offset(by: turretField.pos.toSize) }
    }
    var playElems: [PlayElemController] {
        return globalTurrets + [heart]
    }
    
    convenience init(direction: PlayerDirection, parentSize: CellSize) {
        self.init(curModel: PlayerModel.empty(direction: direction, parentSize: parentSize))
    }
    
    init(curModel: PlayerModel) {
        direction = curModel.direction
        turretField = GridElemController(curModel: curModel.turretField, display: true)
        heart = HeartElemController(curModel: curModel.heart)
        assert(
            turretField.grid.curElems.isEmpty,
            "Can't create player controller from model with turrets: they wouldn't be part of gameplay."
        )
    }
    
    ///This mode will let the player take their turn, adding a turret to their field, then move on.
    func turnMode(next nextMode: Mode?) -> Mode {
        return AddTurretMode(
            playerDirection: direction,
            turretGrid: turretField.grid,
            next: { turret in
                self._turrets = turret + self.turrets
                return nextMode
            }
        )
    }
}

extension GridController where TElem == Elem {
    ///Adds a player's elements to this grid
    func add(player: PlayerController) {
        add(elem: player.turretField.cast())
        add(elem: player.heart.cast())
    }
    
    ///Removes exactly one player's elements from this grid
    func removeOne(player: PlayerController) throws {
        try removeOne(elem: player.turretField.cast())
        try removeOne(elem: player.heart.cast())
    }
    
    ///Replaces exactly one player's elements from this grid
    func replaceOne(oldPlayer: PlayerController, newPlayer: PlayerController) throws {
        try replaceOne(oldElem: oldPlayer.turretField.cast(), newElem: newPlayer.turretField.cast())
        try replaceOne(oldElem: oldPlayer.heart.cast(), newElem: newPlayer.heart.cast())
    }
}
