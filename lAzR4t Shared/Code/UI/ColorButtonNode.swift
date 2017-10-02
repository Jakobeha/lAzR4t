//
//  ColorButtonNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

class ColorButtonNode: ElemSpriteNode {
    private static func texture(color: AttackColor, isSelected: Bool) -> SKTexture {
        return SKTexture(imageNamed: "\(color.toString)Button\(isSelected ? "Selected" : "")")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode ColorButtonNode")
    }
    
    init(color: AttackColor, isSelected: Bool, pos: CellPos) {
        super.init(
            texture: ColorButtonNode.texture(color: color, isSelected: isSelected),
            color: SKColor.white, //This color is different and won't apply
            size: CellSize.unit.toDisplay
        )
        position = pos.toCenterDisplay
        zPosition = 7 //Above every other element
    }
    
    func reconfigure(color: AttackColor, isSelected: Bool, pos: CellPos) {
        self.texture = ColorButtonNode.texture(color: color, isSelected: isSelected)
        position = pos.toCenterDisplay
    }
}
