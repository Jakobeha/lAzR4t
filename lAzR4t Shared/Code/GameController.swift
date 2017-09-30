//
//  GameController.swift
//  lAzR4t iOS
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

///The ultimate controller of the game. Handles the scene and model.
class GameController {
    let grid: GameGridController
    private var _scene: GameScene!
    var scene: GameScene { return _scene }
    private var _model: GameModel!
    var model: GameModel { return _model }
    var curModes: [String:Mode] = [:]
    var curControlModes: [String:ControlMode] { return curModes.flatMapValues { $0.controlMode } }
    var curTimeModes: [String:TimeMode] { return curModes.flatMapValues { $0.timeMode } }
    
    init(size: CellSize) {
        grid = GameGridController(size: size)
        _scene = GameScene(controller: self, grid: grid.node)
        _model = GameModel(controller: self, grid: grid.model)
    }
}
