//
//  GameGrid.swift
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
struct Grid<TElem> {
    let elems: [TElem]
    let size: CellSize
    var width: Int { return size.width }
    var height: Int { return size.height }
    
    ///Creates an empty grid
    init(size: CellSize) {
        self.elems = []
        self.size = size
    }
}

typealias GameGrid = Grid<Elem>
