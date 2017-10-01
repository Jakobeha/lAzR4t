//
//  Grid.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///A grid of elements, which represents a group of information in the game.
///
///A grid can contain game elements like turrets,
///but it can also contain user interface like buttons.
///You can filter out some of those via `filter`.
struct Grid<TElem: Elem> {
    let elems: List<TElem>
    let size: CellSize
    var bounds: CellFrame { return CellFrame(pos: CellPos.origin, size: self.size) }
    var width: Int { return size.width }
    var height: Int { return size.height }
    
    ///Creates an empty grid
    static func empty(size: CellSize) -> Grid<TElem> {
        return Grid(elems: List.empty, size: size)
    }
    
    init(elems: List<TElem>, size: CellSize) {
        self.elems = elems
        self.size = size
    }
    
    func add(elem: TElem) -> Grid<TElem> {
        return Grid(elems: elem + elems, size: size)
    }
    
    func removeOne(elem: TElem) throws -> Grid<TElem> {
        return Grid(elems: try elems.removeOne(elem), size: size)
    }
    
    func replaceOne(oldElem: TElem, newElem: TElem) throws -> Grid<TElem> {
        return Grid(elems: try elems.replaceOne(oldElem, with: newElem), size: size)
    }
}

typealias GameGrid = Grid<Elem>
