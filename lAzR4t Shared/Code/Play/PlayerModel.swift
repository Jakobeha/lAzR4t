//
//  PlayerModel.swift
//  lAzR4t iOS
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Contains everything semantically involving the player.
class PlayerModel {
    static let turretAreaSize: CellSize = CellSize(width: 4, height: 6)
    
    let turretArea: GridElem<TurretElem>
    var turretGrid: Grid<TurretElem> { return turretArea.grid }
    let heart: HeartElem
    
    ///Creates an empty player model for a grid of the given size, facing the given direction.
    ///Usually, the grid will be standard 15x10 size.
    static func empty(parentSize: CellSize, direction: PlayerDirection) -> PlayerModel {
        //A game has 2 player fields vertically aligned, with a gap of 3 cells in between
        let playerFieldSize = CellSize(
            width: (parentSize.width - 3) / 2,
            height: parentSize.height
        )
        let playerFieldFrame = direction.anchor(playerFieldSize, in: parentSize)
        let turretAreaFrame = direction.opposite.anchor(PlayerModel.turretAreaSize, in: playerFieldFrame)
        ///The heart takes up all the area a square can,
        //still leaving space for the turret area and a gap of 1 cell
        let heartSize = CellSize(
            width: playerFieldSize.width - PlayerModel.turretAreaSize.width - 1,
            height: playerFieldSize.height
        )
        let heartFrame = direction.anchor(heartSize, in: playerFieldFrame)
        
        return PlayerModel(
            turretArea: GridElem.empty(frame: turretAreaFrame),
            heart: HeartElem(direction: direction, frame: heartFrame)
        )
    }
    
    init(turretArea: GridElem<TurretElem>, heart: HeartElem) {
        self.turretArea = turretArea
        self.heart = heart
    }
    
    func set(turretArea newTurretArea: GridElem<TurretElem>) -> PlayerModel {
        return PlayerModel(turretArea: newTurretArea, heart: self.heart)
    }
    
    func set(heart newHeart: HeartElem) -> PlayerModel {
        return PlayerModel(turretArea: self.turretArea, heart: newHeart)
    }
}

extension Grid where TElem == Elem {
    ///Adds a player's elements to this grid
    func add(player: PlayerModel) -> Grid<TElem> {
        return self
            .add(elem: player.heart)
            .add(elem: player.turretArea)
    }
    
    ///Removes exactly one player's elements from this grid
    func removeOne(player: PlayerModel) throws -> Grid<TElem> {
        return try self
            .removeOne(elem: player.heart)
            .removeOne(elem: player.turretArea)
    }
    
    ///Replaces exactly one player's elements from this grid
    func replaceOne(oldPlayer: PlayerModel, newPlayer: PlayerModel) throws -> Grid<TElem> {
        return try self
            .replaceOne(oldElem: oldPlayer.heart, newElem: newPlayer.heart)
            .replaceOne(oldElem: oldPlayer.turretArea, newElem: newPlayer.heart)
    }
}
