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
    private let controller: GameController
    private let grid: GameGrid
    
    init(controller: GameController, grid: GameGrid) {
        self.controller = controller
        self.grid = grid
    }
    
    func set(grid newGrid: GameGrid) -> GameModel {
        return GameModel(controller: self.controller, grid: newGrid)
    }
}
