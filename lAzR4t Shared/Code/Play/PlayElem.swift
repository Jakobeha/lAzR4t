//
//  PlayElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An element in the game world: a turret, projectile, etc. but not a button.
class PlayElem: Elem {
    ///Returns the element after it absorbs the projectile,
    ///if it survived, or nothing if it got destroyed.
    func absorb(projectile: ProjectileElem) -> PlayElem? {
        return self
    }
}
