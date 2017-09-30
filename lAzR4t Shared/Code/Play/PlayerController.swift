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
    let turretArea: GridElemController<TurretElem>
    let heart: HeartElemController
    var curModel: PlayerModel {
        return PlayerModel(turretArea: turretArea.curModel, heart: heart.curModel)
    }
    var curTurretGrid: Grid<TurretElem> { return turretArea.curModel.grid }
    
    convenience init(parentSize: CellSize, direction: PlayerDirection) {
        self.init(curModel: PlayerModel.empty(parentSize: parentSize, direction: direction))
    }
    
    init(curModel: PlayerModel) {
        turretArea = GridElemController(curModel: curModel.turretArea, display: true)
        heart = HeartElemController(curModel: curModel.heart)
    }
}

extension GridController where TElem == Elem {
    ///Adds a player's elements to this grid
    func add(player: PlayerController) {
        add(elem: player.turretArea.cast())
        add(elem: player.heart.cast())
    }
    
    ///Removes exactly one player's elements from this grid
    func removeOne(player: PlayerController) throws {
        try removeOne(elem: player.turretArea.cast())
        try removeOne(elem: player.heart.cast())
    }
    
    ///Replaces exactly one player's elements from this grid
    func replaceOne(oldPlayer: PlayerController, newPlayer: PlayerController) throws {
        try replaceOne(oldElem: oldPlayer.turretArea.cast(), newElem: newPlayer.turretArea.cast())
        try replaceOne(oldElem: oldPlayer.heart.cast(), newElem: newPlayer.heart.cast())
    }
}
