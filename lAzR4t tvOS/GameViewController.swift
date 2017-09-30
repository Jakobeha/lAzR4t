//
//  GameViewController.swift
//  lAzR4t tvOS
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
