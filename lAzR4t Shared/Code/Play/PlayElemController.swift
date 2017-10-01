//
//  PlayElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

protocol PlayElemController {
    var curModel_play: PlayElem_base & PlayElem { get }
    var isInPlay: Bool { get }
    
    ///Modifies the element so it absorbs the projectile,
    ///and potentially removes it if it got destroyed.
    func absorb(projectile: ProjectileElem)
    ///Removes this element from the game, so it doens't affect game mechanics anymore.
    ///`isInPlay` should be false after this.
    ///You can't call this on an already-removed element.
    func removeFromPlay()
}

class PlayElemController_impl<TElem: PlayElem>: SimpleElemController<TElem>, PlayElemController {
    var curModel_play: PlayElem_base & PlayElem { return curModel }
    var isInPlay: Bool { return isInWorld }
    
    func absorb(projectile: ProjectileElem) {
        guard let newModel = curModel.absorb(projectile: projectile) else {
            //Got removed
            if self.isInPlay {
                removeFromPlay()
            }
            return
        }
        curModel = newModel
    }
    
    func removeFromPlay() {
        removeFromWorld()
    }
}
