//
//  ProjectileElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ProjectileElem: PlayElem {
    ///The color of the projectile, which control its type. Can't be empty.
    let colors: List<AttackColor>
    let direction: CellDirection
    var x: Int { return pos.x }
    var y: Int { return pos.y }
    var damage: Int {
        return colors.damage
    }
    
    convenience init(color: AttackColor, direction: CellDirection, pos: CellPos) {
        self.init(colors: List(item: color), direction: direction, pos: pos)
    }
    
    init(colors: List<AttackColor>, direction: CellDirection, pos: CellPos) {
        self.colors = colors
        self.direction = direction
        super.init(pos: pos, size: CellSize.unit)
        
        assert(!colors.isEmpty, "Projectile needs at least one color")
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? ProjectileElem else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.colors == self.colors) &&
            (other.direction == self.direction)
    }
}
