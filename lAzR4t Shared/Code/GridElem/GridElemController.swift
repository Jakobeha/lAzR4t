//
//  GridController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

final class GridElemController<TSub: Elem>: ElemController<GridElem<TSub>> {
    let grid: GridController<TSub>
    var _pos: CellPos
    var pos: CellPos {
        get { return _pos }
        set(newPos) {
            _pos = newPos
            grid.node.position = pos.toDisplay
        }
    }
    var frame: CellFrame { return curModel.frame }
    ///Not this element's actual node. This is an actual represetnation of a grid.
    let gridNode: GridElemNode?
    override var curModel: GridElem<TSub> {
        return GridElem(pos: self.pos, grid: self.grid.curModel)
    }
    
    convenience init(frame: CellFrame, display: Bool) {
        self.init(pos: frame.pos, size: frame.size, display: display)
    }
    
    convenience init(pos: CellPos, size: CellSize, display: Bool) {
        let node = ElemNode()
        node.position = pos.toDisplay
        self.init(
            grid: GridController(size: size, node: node),
            pos: pos,
            display: display
        )
    }
    
    private init(grid: GridController<TSub>, pos: CellPos, display: Bool) {
        self.grid = grid
        self._pos = pos
        self.gridNode = display ? GridElemNode(cellSize: grid.curModel.size) : nil
        super.init(node: grid.node)
        
        if let gridNode = gridNode {
            grid.node.addChild(gridNode)
        }
    }
}

extension GridElemController where TSub: ElemToController {
    convenience init(curModel: GridElem<TSub>, display: Bool) {
        let node = ElemNode()
        node.position = curModel.pos.toDisplay
        self.init(
            grid: GridController(curModel: curModel.grid, node: node),
            pos: curModel.pos,
            display: display
        )
    }
}
