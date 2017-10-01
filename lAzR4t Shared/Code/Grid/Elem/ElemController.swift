//
//  ElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ElemController<TElem: Elem>: Equatable {
    var curModel: TElem {
        fatalError(
            "Not implemented. Don't make instances of this directly, use MinElemController or another subclass. " +
            "Would've made ElemController a protocol but protocols in Swift are tough and limited"
        )
    }
    let node: ElemNode?
    private var _parent: GridController<TElem>?
    var parent: GridController<TElem>? { return _parent }
    var isInWorld: Bool
    
    static func ==(_ a: ElemController<TElem>, _ b: ElemController<TElem>) -> Bool {
        return a.curModel == b.curModel
    }
    
    init(node: ElemNode?) {
        self.node = node
        self._parent = nil
        self.isInWorld = true
    }
    
    ///Removes this element from all parents and scenes.
    ///Should remove it from connections to other elements.
    ///You can't call this function on an already-removed element.
    func removeFromWorld() {
        assert(isInWorld, "Element has already been removed from the world -- can't remove twice.")
        
        node?.removeFromParent()
        if let parent = parent {
            //Has a parent
            try! parent.removeOne(elem: self)
        }
        
        isInWorld = false
    }
    
    ///Casts this controller's element to a superclass.
    ///Actually performes a forced cast on the element,
    ///but should only be used to make it super.
    ///
    ///warning: Make sure that TElem2 conforms to TElem, or this will fail at runtime.
    func cast<TElem2: Elem>() -> ElemController<TElem2> {
        return ForeignCastElemController<TElem2, TElem>(orig: self)
    }
    
    internal func _add(parent newParent: GridController<TElem>) {
        assert(self._parent == nil, "Element controller can't have two parents")
        self._parent = newParent
    }
    
    internal func _remove(parent: GridController<TElem>) {
        self._parent = nil
    }
}
