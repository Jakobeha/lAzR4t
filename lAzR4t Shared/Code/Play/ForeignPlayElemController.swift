//
//  ForeignPlayElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Lets you use a PlayElemController in a different grid,
///by giving it an offset elem,
///but using the same node and making absorbtion affect the original.
class ForeignPlayElemController<TElem: PlayElem>: ElemController<TElem>, PlayElemController {
    let curModelOffset: CellSize
    let orig: PlayElemController_impl<TElem>
    override var curModel: TElem { return orig.curModel.offset(by: curModelOffset) }
    var curModel_play: PlayElem_base & PlayElem { return orig.curModel_play.offset(by: curModelOffset) }
    var isInPlay: Bool { return orig.isInPlay}
    
    init(curModelOffset: CellSize, orig: PlayElemController_impl<TElem>) {
        self.curModelOffset = curModelOffset
        self.orig = orig
        super.init(node: orig.node)
    }
    
    func absorb(projectile: ProjectileElem) {
        orig.absorb(projectile: projectile)
    }
    
    func removeFromPlay() {
        orig.removeFromPlay()
    }
}

extension PlayElemController_impl {
    func offset(by offset: CellSize) -> ForeignPlayElemController<TElem> {
        return ForeignPlayElemController(curModelOffset: offset, orig: self)
    }
}
