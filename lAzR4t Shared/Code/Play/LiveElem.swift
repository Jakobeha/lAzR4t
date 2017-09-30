//
//  LiveElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An element which can be damaged and destroyed
class LiveElem: PlayElem {
    let health: Int
    
    init(health: Int, pos: CellPos, size: CellSize) {
        assert(health > 0, "Can't have live element with no health: it would already be dead")
        self.health = health
        super.init(pos: pos, size: size)
    }
    
    func set(health newHealth: Int) -> LiveElem {
        return LiveElem(health: newHealth, pos: self.pos, size: self.size)
    }
    
    ///Returns this element damaged if it survives,
    ///and doesn't return anything if it gets destroyed.
    func damage(_ amount: Int) -> LiveElem? {
        if (amount >= health) {
            return nil
        } else {
            return self.set(health: health - amount)
        }
    }
    
    override func absorb(projectile: ProjectileElem) -> LiveElem? {
        return self.damage(projectile.damage)
    }
}
