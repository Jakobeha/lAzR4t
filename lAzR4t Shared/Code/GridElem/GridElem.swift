//
//  GridElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

final class GridElem<TSub: Elem>: Elem {
    let grid: Grid<TSub>
    
    static func empty(frame: CellFrame) -> GridElem {
        return GridElem.empty(pos: frame.pos, size: frame.size)
    }
    
    static func empty(pos: CellPos, size: CellSize) -> GridElem {
        return GridElem(pos: pos, grid: Grid.empty(size: size))
    }
    
    init(pos: CellPos, grid: Grid<TSub>) {
        self.grid = grid
        super.init(pos: pos, size: grid.size)
    }
    
    func add(subElem: TSub) -> GridElem<TSub> {
        return self.set(grid: self.grid.add(elem: subElem))
    }
    
    func removeOne(subElem: TSub) throws -> GridElem<TSub> {
        return self.set(grid: try self.grid.removeOne(elem: subElem))
    }
    
    override func set(pos newPos: CellPos) -> GridElem<TSub> {
        return GridElem(pos: newPos, grid: self.grid)
    }
    
    func set(grid newGrid: Grid<TSub>) -> GridElem<TSub> {
        return GridElem(pos: self.pos, grid: newGrid)
    }
}
