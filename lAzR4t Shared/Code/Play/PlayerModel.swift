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
    static let turretFieldSize: CellSize = CellSize(width: 4, height: 6)
    
    let direction: PlayerDirection
    let turretField: GridElem<TurretElem>
    var turretGrid: Grid<TurretElem> { return turretField.grid }
    let heart: HeartElem
    ///The player's turrets, in the model's own scope, not their local field.
    var globalTurrets: [TurretElem] {
        return turretGrid.elems.toArray.map { $0.offset(by: turretField.pos.toSize) }
    }
    var playElems: [PlayElem] {
        return globalTurrets + [heart]
    }
    var lost: Bool { return heart.health <= 0 }
    
    ///Creates an empty player model for a grid of the given size, facing the given direction.
    ///Usually, the grid will be standard 15x10 size.
    static func empty(direction: PlayerDirection, parentSize: CellSize) -> PlayerModel {
        //A game has 2 player fields vertically aligned, with a gap of 3 cells in between
        let playerFieldSize = CellSize(
            width: (parentSize.width - 3) / 2,
            height: parentSize.height
        )
        let playerFieldFrame = direction.anchor(playerFieldSize, in: parentSize)
        let turretFieldFrame = direction.opposite.anchor(PlayerModel.turretFieldSize, in: playerFieldFrame)
        ///The heart takes up all the area a square can,
        //still leaving space for the turret area and a gap of 1 cell
        let heartSize = CellSize(
            width: playerFieldSize.width - PlayerModel.turretFieldSize.width - 1,
            height: playerFieldSize.height
        )
        let heartFrame = direction.anchor(heartSize, in: playerFieldFrame)
        
        return PlayerModel(
            direction: direction,
            turretField: GridElem.empty(frame: turretFieldFrame),
            heart: HeartElem(direction: direction, frame: heartFrame)
        )
    }
    
    init(direction: PlayerDirection, turretField: GridElem<TurretElem>, heart: HeartElem) {
        self.direction = direction
        self.turretField = turretField
        self.heart = heart
        
        assert(heart.direction == direction)
    }
    
    func set(turretField newturretField: GridElem<TurretElem>) -> PlayerModel {
        return PlayerModel(direction: self.direction, turretField: newturretField, heart: self.heart)
    }
    
    func set(heart newHeart: HeartElem) -> PlayerModel {
        return PlayerModel(direction: self.direction, turretField: self.turretField, heart: newHeart)
    }
}

extension Grid where TElem == Elem {
    ///Adds a player's elements to this grid
    func add(player: PlayerModel) -> Grid<TElem> {
        return self
            .add(elem: player.heart)
            .add(elem: player.turretField)
    }
    
    ///Removes exactly one player's elements from this grid
    func removeOne(player: PlayerModel) throws -> Grid<TElem> {
        return try self
            .removeOne(elem: player.heart)
            .removeOne(elem: player.turretField)
    }
    
    ///Replaces exactly one player's elements from this grid
    func replaceOne(oldPlayer: PlayerModel, newPlayer: PlayerModel) throws -> Grid<TElem> {
        return try self
            .replaceOne(oldElem: oldPlayer.heart, newElem: newPlayer.heart)
            .replaceOne(oldElem: oldPlayer.turretField, newElem: newPlayer.heart)
    }
}
