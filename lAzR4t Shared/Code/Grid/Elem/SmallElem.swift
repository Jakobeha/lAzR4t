//
//  SmallElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An `Elem` which only takes up one cell
class SmallElem: Elem {
    var x: Int { return pos.x }
    var y: Int { return pos.y }
    
    init(pos: CellPos) {
        super.init(pos: pos, size: CellSize.unit)
    }
}
