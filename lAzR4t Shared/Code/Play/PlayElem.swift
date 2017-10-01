//
//  PlayElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

typealias PlayElem_base = Elem

///An element in the game world: a turret, projectile, etc. but not a button.
protocol PlayElem where Self: PlayElem_base {
    func set(pos: CellPos) -> Self
    
    ///Returns the element after it absorbs the projectile,
    ///if it survived, or nothing if it got destroyed.
    func absorb(projectile: ProjectileElem) -> Self?
}

extension PlayElem {
    func offset(by offset: CellSize) -> Self {
        return set(pos: self.pos + offset)
    }
}
