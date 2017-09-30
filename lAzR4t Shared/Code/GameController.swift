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
    private var _scene: GameScene!
    private var _model: GameModel!
    var curModes: [String:Mode] = [:]
    var scene: GameScene { return _scene }
    var model: GameModel { return _model }
    var curControlModes: [String:ControlMode] { return curModes.flatMapValues { $0.controlMode } }
    var curTimeModes: [String:TimeMode] { return curModes.flatMapValues { $0.timeMode } }
    
    init() {
        _scene = GameScene(controller: self)
        _model = GameModel(controller: self)
    }
}
