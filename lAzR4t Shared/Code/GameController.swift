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
    let grid: GridController<Elem>
    private var _scene: GameScene! = nil
    var scene: GameScene { return _scene }
    private var _curModel: GameModel! = nil
    var curModel: GameModel { return _curModel }
    var curModes: [String:Mode] = [:]
    var curControlModes: [String:ControlMode] { return curModes.flatMapValues { $0.controlMode } }
    var curTimeModes: [String:TimeMode] { return curModes.flatMapValues { $0.timeMode } }
    
    init(size: CellSize) {
        grid = GridController(size: size)
        _curModel = GameModel(controller: self, grid: grid.curModel)
        _scene = GameScene(controller: self, size: size.toDisplay)
        
        grid.onCurModelChange { self._curModel = self.curModel.set(grid: self.grid.curModel) }
    }
    
    func add(elem: ElemController<Elem>) {
        grid.add(elem: elem)
    }
}
