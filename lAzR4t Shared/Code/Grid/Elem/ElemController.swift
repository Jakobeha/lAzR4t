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
    
    static func ==(_ a: ElemController<TElem>, _ b: ElemController<TElem>) -> Bool {
        return a.curModel == b.curModel
    }
    
    init(node: ElemNode?) {
        self.node = node
    }
    
    ///Casts this controller's element to a superclass.
    ///Actually performes a forced cast on the element,
    ///but should only be used to make it super.
    ///
    ///warning: Make sure that TElem2 conforms to TElem, or this will fail at runtime.
    func cast<TElem2: Elem>() -> ElemController<TElem2> {
        return RefElemController<TElem2>(getCurModel: { self.curModel as! TElem2 }, node: self.node)
    }
    
    internal func _add(parent: GridController<TElem>) {
        //Doesn't need to track parents
    }
    
    internal func _remove(parent: GridController<TElem>) {
        //Doesn't need to track parents
    }
}

///Just gets another element's properties.
///Elements can be downcasted to this -- used for downcasting.
fileprivate class RefElemController<TElem: Elem>: ElemController<TElem> {
    override var curModel: TElem { return getCurModel() }
    let getCurModel: () -> TElem
    
    init(getCurModel: @escaping () -> TElem, node: ElemNode?) {
        self.getCurModel = getCurModel
        super.init(node: node)
    }
}
