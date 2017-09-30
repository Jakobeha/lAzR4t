//
//  SmallElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An `Elem` which only takes up one cell
protocol SmallElem {
    var pos: CellPos { get }
}

extension SmallElem {
    var frame: CellFrame { return CellFrame(pos: self.pos, size: CellSize.unit) }
    
    var x: Int { return pos.x }
    var y: Int { return pos.y }
}
