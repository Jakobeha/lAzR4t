//
//  GameViewController.swift
//  lAzR4t macOS
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = GameController()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(controller.scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

}

