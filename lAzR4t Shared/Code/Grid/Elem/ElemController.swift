//
//  ElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ElemController<TElem: Elem> {
    private var _curModel: TElem
    internal var curModel: TElem {
        get { return _curModel }
        set(newCurModel) {
            parents.forEach { $0._replace(oldModel: curModel, newModel: newCurModel) }
            _curModel = newCurModel
        }
    }
    let node: ElemNode?
    private var parents: List<GridController<TElem>> = List.empty
    
    init(curModel: TElem, node: ElemNode?) {
        self.node = node
        self._curModel = curModel //Don't worry about setter, doesn't have parents yet
    }
    
    internal func _add(parent: GridController<TElem>) {
        parents = parent + parents
    }
    
    internal func _remove(parent: GridController<TElem>) {
        parents = try! parents.removeOne(parent)
    }
}
