//
//  Cell.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An item, like a turret or user button.
class Elem: Equatable {
    let pos: CellPos
    let size: CellSize
    var frame: CellFrame { return CellFrame(pos: self.pos, size: self.size) }
    
    static func overlap(_ a: Elem, _ b: Elem) -> Bool {
        return CellFrame.overlap(a.frame, b.frame)
    }
    
    static func ==(_ a: Elem, _ b: Elem) -> Bool {
        return a === b
    }
    
    init(pos: CellPos, size: CellSize) {
        self.pos = pos
        self.size = size
    }
    
    convenience init(frame: CellFrame) {
        self.init(pos: frame.pos, size: frame.size)
    }
    
    func set(pos newPos: CellPos) -> Elem {
        return Elem(pos: newPos, size: self.size)
    }
    
    final func offset(by offset: CellSize) -> Elem {
        return self.set(pos: self.pos + offset)
    }
}
