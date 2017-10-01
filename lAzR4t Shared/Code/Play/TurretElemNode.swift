//
//  TurretElemNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

class TurretElemNode: ElemNode {
    private static let placeholderAlpha: CGFloat = 0.5
    
    private let head: ElemSpriteNode
    private let barrel: ElemSpriteNode
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode TurretElemNode.")
    }
    
    init(healthRatio: CGFloat, color: AttackColor, direction: CellDirection, isPlaceholder: Bool, pos: CellPos) {
        barrel = ElemSpriteNode(imageNamed: "TurretBarrel")
        barrel.anchorPoint = CGPoint(x: 0, y: 0.5)
        barrel.zRotation = direction.toRotation
        barrel.zPosition = 1 //Below head, but above grid
        head = ElemSpriteNode(
            texture: SKTexture(imageNamed: "\(color.toString)Head"),
            color: SKColor.white, //Color is in texture. This doesn't actually do anything.
            size: CellSize.unit.toDisplay
        )
        head.zPosition = 2 //Above grid and barrel
        super.init()
        
        alpha = (isPlaceholder ? TurretElemNode.placeholderAlpha : 1) * healthRatio
        position = pos.toCenterDisplay
        addChild(barrel)
        addChild(head)
    }
    
    func reconfigure(healthRatio: CGFloat, color: AttackColor, direction: CellDirection, isPlaceholder: Bool, pos: CellPos) {
        barrel.zRotation = direction.toRotation
        head.texture = SKTexture(imageNamed: "\(color.toString)Head")
        head.size = CellSize.unit.toDisplay
        alpha = (isPlaceholder ? TurretElemNode.placeholderAlpha : 1) * healthRatio
        position = pos.toCenterDisplay
    }
}
