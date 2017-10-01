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
    
    init() {
        let curModel = GameModel.empty
        scene = GameScene(size: GameModel.gameSize.toDisplay)
        grid = GridController(size: GameModel.gameSize, node: scene)
        players = curModel.players.mapValues { PlayerController(curModel: $0) }
        
        scene.controller = self
        players.values.forEach { grid.add(player: $0) }
        
        curModes["turn"] = regTurnMode()
    }
    
    private func regTurnMode() -> Mode {
        return players[PlayerDirection.left]!.turnMode(
            next: players[PlayerDirection.right]!.turnMode(
                next: LazyMode(regTurnMode)
            )
        )
    }
    
    private func add(elem: ElemController<Elem>) {
        grid.add(elem: elem)
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        curModes = curModes.flatMapValues { $0.update(gameTime: currentTime, in: self.grid) }
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameController {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.touchesBegan(touches, with: event, in: self.grid) }
        }
        
        func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.touchesMoved(touches, with: event, in: self.grid) }
        }
        
        func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.touchesEnded(touches, with: event, in: self.grid) }
        }
        
        func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            curModes = curModes.flatMapValues { $0.touchesCancelled(touches, with: event, in: self.grid) }
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameController {
        func mouseDown(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.mouseDown(with: event, in: self.grid) }
        }
        
        func mouseDragged(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.mouseDragged(with: event, in: self.grid) }
        }
        
        func mouseUp(with event: NSEvent) {
            curModes = curModes.flatMapValues { $0.mouseUp(with: event, in: self.grid) }
        }
    }
#endif
