//
//  GridController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class GridController<TElem: Elem>: Equatable {
    private var _curModel: Grid<TElem>
    var curModel: Grid<TElem> { return _curModel }
    private var _curElems: List<ElemController<TElem>>
    var curElems: List<ElemController<TElem>> { return _curElems }
    private var _onCurModelChange: () -> Void = { }
    
    static func ==(_ a: GridController<TElem>, _ b: GridController<TElem>) -> Bool {
        return a === b
    }
    
    init(size: CellSize) {
        _curModel = Grid.empty(size: size)
        _curElems = List.empty
    }
    
    func add(elem: ElemController<TElem>) {
        _curModel = _curModel.add(elem: elem.curModel)
        elem._add(parent: self)
        _onCurModelChange()
    }
    
    func removeOne(elem: ElemController<TElem>) throws {
        elem._remove(parent: self)
        _curModel = try _curModel.removeOne(elem: elem.curModel)
        _onCurModelChange()
    }
    
    func replaceOne(oldElem: ElemController<TElem>, newElem: ElemController<TElem>) throws {
        oldElem._remove(parent: self)
        _curModel = try _curModel.replaceOne(oldElem: oldElem.curModel, newElem: newElem.curModel)
        newElem._add(parent: self)
        _onCurModelChange()
    }
    
    func onCurModelChange(_ action: @escaping () -> Void) {
        let oldOnCurModelChange = _onCurModelChange
        _onCurModelChange = {
            oldOnCurModelChange()
            action()
        }
    }
    
    internal func _replace(oldModel: TElem, newModel: TElem) {
        _curModel = try! _curModel.replaceOne(oldElem: oldModel, newElem: newModel)
    }
}

typealias GameGridController = GridController<Elem>
