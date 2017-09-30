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
    let players: [PlayerDirection:PlayerController]
    let scene: GameScene
    private var curModel: GameModel {
        return GameModel(players: self.players.mapValues { $0.curModel })
    }
    var curModes: [String:Mode] = [:]
    var curControlModes: [String:ControlMode] { return curModes.flatMapValues { $0.controlMode } }
    var curTimeModes: [String:TimeMode] { return curModes.flatMapValues { $0.timeMode } }
    
    init() {
        let curModel = GameModel.empty
        scene = GameScene(size: GameModel.gameSize.toDisplay)
        grid = GridController(size: GameModel.gameSize, node: scene)
        players = curModel.players.mapValues { PlayerController(curModel: $0) }
        
        scene.controller = self
        players.values.forEach { grid.add(player: $0) }
    }
    
    private func add(elem: ElemController<Elem>) {
        grid.add(elem: elem)
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        curModes = curModes.flatMapValues { $0.timeMode?.update(gameTime: currentTime) ?? [$0] }
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameController {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.controlMode?.touchesBegan(touches, with: event) ?? [$0] }
        }
        
        func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.controlMode?.touchesMoved(touches, with: event) ?? [$0] }
        }
        
        func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.controlMode?.touchesEnded(touches, with: event) ?? [$0] }
        }
        
        func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.controlMode?.touchesCancelled(touches, with: event) ?? [$0] }
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameController {
        func mouseDown(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.controlMode?.mouseDown(with: event) ?? [$0] }
        }
        
        func mouseDragged(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.controlMode?.mouseDragged(with: event) ?? [$0] }
        }
        
        func mouseUp(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.controlMode?.mouseUp(with: event) ?? [$0] }
        }
    }
#endif
