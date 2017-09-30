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
    ///The regular size of all scenes
    static let regSize: CGSize = CGSize(width: 1280, height: 768)
    
    fileprivate let controller: GameController
    var curControlModes: [String:ControlMode] { return controller.curControlModes }
    var curTimeModes: [String:TimeMode] { return controller.curTimeModes }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode GameScene. Create it with `init(controller: GameController)`")
    }
    
    init(controller: GameController) {
        self.controller = controller
        super.init(size: GameScene.regSize)
        
        setup()
    }
    
    private func setup() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        curTimeModes.values.forEach { $0.update(gameTime: currentTime) }
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        curControlModes.values.forEach { $0.touchesBegan(touches, with: event) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        curControlModes.values.forEach { $0.touchesMoved(touches, with: event) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        curControlModes.values.forEach { $0.touchesEnded(touches, with: event) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        curControlModes.values.forEach { $0.touchesCancelled(touches, with: event) }
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {
    override func mouseDown(with event: NSEvent) {
        curControlModes.values.forEach { $0.mouseDown(with: event) }
    }
    
    override func mouseDragged(with event: NSEvent) {
        curControlModes.values.forEach { $0.mouseDragged(with: event) }
    }
    
    override func mouseUp(with event: NSEvent) {
        curControlModes.values.forEach { $0.mouseUp(with: event) }
    }
}
#endif

