//
//  SimpleElemController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An element controller which is simple enough so it's entire model can be set directly:
///specifically, an element controller without sub-controllers.
///
///If the controller has sub-controllers, it's model can't be set directly,
///because elements in the model need controllers but they aren't given in the set.
class SimpleElemController<TElem: Elem>: ElemController<TElem> {
    private var _curModel: TElem
    override var curModel: TElem {
        get { return _curModel }
        set(newCurModel) {
            if let parent = self.parent {
                try! parent._curModel = parent._curModel.replaceOne(oldElem: curModel, newElem: newCurModel)
            }
            _curModel = newCurModel
        }
    }
    
    ///Creates an element controller with a sprite node with a specific texture.
    convenience init(curModel: TElem, textureName: String) {
        self.init(curModel: curModel, node: ElemSpriteNode(imageNamed: textureName))
    }
    
    init(curModel: TElem, node: ElemNode?) {
        self._curModel = curModel //Don't worry about setter, doesn't have parents yet
        super.init(node: node)
    }
}
