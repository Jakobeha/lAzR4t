//
//  GridController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

struct GameGridController {
    let size: CellSize
    let model: GameGrid
    let node: GameGridNode
    
    init(size: CellSize) {
        self.size = size
        self.model = GameGrid(size: size)
        self.node = GameGridNode(cellSize: size)
    }
}
