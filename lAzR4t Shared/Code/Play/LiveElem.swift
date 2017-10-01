//
//  LiveElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An element which can be damaged and destroyed
class LiveElem_base: Elem {
    let health: Int
    
    init(health: Int, pos: CellPos, size: CellSize) {
        assert(health > 0, "Can't have live element with no health: it would already be dead")
        self.health = health
        super.init(pos: pos, size: size)
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? LiveElem_base else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.health == self.health)
    }
}

protocol LiveElem: PlayElem where Self: LiveElem_base {
    func set(health newHealth: Int) -> Self
}

extension LiveElem {
    ///Returns this element damaged if it survives,
    ///and doesn't return anything if it gets destroyed.
    func damage(_ amount: Int) -> Self? {
        if (amount >= health) {
            return nil
        } else {
            return self.set(health: health - amount)
        }
    }
    
    func absorb(projectile: ProjectileElem) -> Self? {
        return damage(projectile.damage)
    }
}
