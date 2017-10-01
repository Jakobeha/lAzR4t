//
//  GridController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class GridController<TElem: Elem>: Equatable {
    internal var _curModel: Grid<TElem>
    var curModel: Grid<TElem> { return _curModel }
    private var _curElems: List<ElemController<TElem>>
    var curElems: List<ElemController<TElem>> { return _curElems }
    ///The node where elements in the grid will be added to.
    let node: ElemNode
    
    static func ==(_ a: GridController<TElem>, _ b: GridController<TElem>) -> Bool {
        return a === b
    }
    
    fileprivate init(curModel: Grid<TElem>, curElems: List<ElemController<TElem>>, node: ElemNode) {
        self.node = node
        _curModel = curModel
        _curElems = curElems
    }
    
    convenience init(size: CellSize, node: ElemNode) {
        self.init(curModel: Grid.empty(size: size), curElems: List.empty, node: node)
    }
    
    func add(elem: ElemController<TElem>) {
        _curModel = _curModel.add(elem: elem.curModel)
        _curElems = elem + _curElems
        elem._add(parent: self)
        if let elemNode = elem.node {
            self.node.addChild(elemNode)
        }
    }
    
    ///note: Type param is unchecked, but needs to conform or equal TElem
    func removeOne(elem: ElemController<TElem>) throws {
        elem._remove(parent: self)
        _curModel = try _curModel.removeOne(elem: elem.curModel)
        _curElems = try _curElems.removeOne(elem)
        elem.node?.removeFromParent()
    }
    
    func replaceOne(oldElem: ElemController<TElem>, newElem: ElemController<TElem>) throws {
        oldElem._remove(parent: self)
        _curModel = try _curModel.replaceOne(oldElem: oldElem.curModel, newElem: newElem.curModel)
        _curElems = try _curElems.replaceOne(oldElem, with: newElem)
        newElem._add(parent: self)
        oldElem.node?.removeFromParent()
        if let newElemNode = newElem.node {
            self.node.addChild(newElemNode)
        }
    }
}

extension GridController where TElem: ElemToController {
    convenience init(curModel: Grid<TElem>, node: ElemNode) {
        self.init(
            curModel: curModel,
            curElems: curModel.elems.map { $0.makeController() },
            node: node
        )
    }
}

typealias GameGridController = GridController<Elem>
