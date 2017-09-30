//
//  TurretElemNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

class TurretElemNode: ElemNode {
    private let head: ElemSpriteNode
    private let barrel: ElemSpriteNode
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode TurretElemNode.")
    }
    
    init(color: AttackColor, direction: CellDirection, size: CellSize) {
        barrel = ElemSpriteNode(imageNamed: "TurretBarrel")
        barrel.anchorPoint = CGPoint(x: 0, y: 0.5)
        barrel.zRotation = direction.toRotation
        head = ElemSpriteNode(
            texture: SKTexture(imageNamed: "\(color.toString)Head"),
            color: SKColor.white, //Color is in texture. This doesn't actually do anything.
            size: size.toDisplay
        )
        super.init()
        
        addChild(self.barrel)
        addChild(self.head)
    }
    
    func reconfigure(color: AttackColor, direction: CellDirection, size: CellSize) {
        self.barrel.zRotation = direction.toRotation
        self.head.texture = SKTexture(imageNamed: "\(color.toString)Head")
        self.head.size = size.toDisplay
    }
}
