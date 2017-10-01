//
//  ProjectileElemNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

class ProjectileElemNode: ElemSpriteNode {
    ///The extra size a projectile gets for its colors
    static func bonusSize(colors: List<AttackColor>) -> CGSize {
        let bonus = bonusSideLength(colors: colors)
        return CGSize(width: bonus, height: bonus)
    }
        
    static func bonusSideLength(colors: List<AttackColor>) -> CGFloat {
        return CGFloat(colors.numDuplicates) * CellDisplay.sideLength / 4
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode ProjectileElemNode.")
    }
    
    init(colors: List<AttackColor>, direction: CellDirection, pos: CellPos, offset: CGFloat) {
        super.init(
            texture: SKTexture(imageNamed: "\(colors.toSetString)Projectile"),
            color: SKColor.white, //Color is inside of texture; won't actually be colorized
            size: CellSize.unit.toDisplay + ProjectileElemNode.bonusSize(colors: colors)
        )
        
        reconfigure(direction: direction, pos: pos, offset: offset)
    }
    
    func reconfigure(colors: List<AttackColor>, direction: CellDirection, pos: CellPos, offset: CGFloat) {
        texture = SKTexture(imageNamed: "\(colors.toSetString)Projectile")
        size = CellSize.unit.toDisplay + ProjectileElemNode.bonusSize(colors: colors)
        reconfigure(direction: direction, pos: pos, offset: offset)
    }
    
    func reconfigure(direction: CellDirection, pos: CellPos, offset: CGFloat) {
        zRotation = direction.toRotation
        position = pos.toCenterDisplay + direction.displayOffset(in: offset)
    }
}

extension List where T == AttackColor {
    ///A string containing each of the types of colors in this list.
    //Each color isn't contained more than ones,
    ///so this is like converting this list into a set and then to a string
    var toSetString: String {
        var curRes = ""
        if contains(AttackColor.red) {
            curRes += "Red"
        }
        if contains(AttackColor.green) {
            curRes += "Green"
        }
        if contains(AttackColor.blue) {
            curRes += "Blue"
        }
        if contains(AttackColor.grey) {
            curRes += "Grey"
        }
        return curRes
    }
}
