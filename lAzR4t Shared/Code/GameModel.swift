//
//  GameModel.swift
//  lAzR4t iOS
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Contains the entire state of the game, down to which turret space is currently highlighted.
///Other classes control specific areas of this state, like the current field.
///
///This will handle "semantic" animation.
///To give an idea, it *won't* handle animations, because if the game doesn't base any mechanics off of them.
///But it *will* handle projectile positions, because the game *does* use them to see if the projectiles collide.
class GameModel {
    static let gameSize: CellSize = CellSize(width: 15, height: 10)
    static let empty: GameModel = GameModel.empty(size: GameModel.gameSize)
    
    let players: [PlayerDirection:PlayerModel]
    
    ///Creates a GameModel to be put in a grid of `size`.
    private static func empty(size: CellSize) -> GameModel {
        return GameModel(players: Dictionary(
            keys: PlayerDirection.all,
            valueGetter: { direction in
                return PlayerModel.empty(direction: direction, parentSize: size)
            }
        ))
    }
    
    init(players: [PlayerDirection:PlayerModel]) {
        self.players = players
    }
}
