//
//  GameScene.swift
//  lAzR4t Shared
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

///Renders the game.
class GameScene: SKScene {
    var controller: GameController?
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode GameScene. Create it with init(controller: GameController)")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        controller?.update(currentTime)
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller?.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller?.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller?.touchesCancelled(touches, with: event)
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {
    override func mouseDown(with event: NSEvent) {
        controller?.mouseDown(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        controller?.mouseDragged(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
        controller?.mouseUp(with: event)
    }
}
#endif

