//
//  ForeignCastElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Just gets and sets another element's properties.
///Elements can be downcasted to this -- used for downcasting.
///This will have a different parent though
class ForeignCastElemController<TElem: Elem, TElemSubcls: Elem>: ElemController<TElem> {
    override var curModel: TElem { return orig.curModel as! TElem }
    let orig: ElemController<TElemSubcls>
    
    init(orig: ElemController<TElemSubcls>) {
        self.orig = orig
        super.init(node: orig.node)
    }
    
    override func removeFromWorld() {
        super.removeFromWorld()
        orig.removeFromWorld()
    }
}
