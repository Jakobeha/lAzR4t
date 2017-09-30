//
//  GridFrame.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class CellFrame {
    let pos: CellPos
    let size: CellSize
    
    var left: Int { return pos.x }
    var bottom: Int { return pos.y }
    var right: Int { return pos.x + size.width }
    var top: Int { return pos.y + size.height }
    var width: Int { return size.width }
    var height: Int { return size.height }
    
    init(pos: CellPos, size: CellSize) {
        self.pos = pos
        self.size = size
    }
    
    convenience init(left: Int, bottom: Int, right: Int, top: Int) {
        self.init(
            pos: CellPos(x: left, y: bottom),
            size: CellSize(width: right - left, height: top - bottom)
        )
    }
    
    func set(pos newPos: CellPos) -> CellFrame {
        return CellFrame(pos: newPos, size: self.size)
    }
    
    func set(size newSize: CellSize) -> CellFrame {
        return CellFrame(pos: self.pos, size: newSize)
    }
    
    func offset(by offset: CellSize) -> CellFrame {
        return self.set(pos: self.pos + offset)
    }
    
    static func overlap(_ a: CellFrame, _ b: CellFrame) -> Bool {
        let horizOverlaps =
            (a.left < b.right && a.right > b.left) ||
            (a.right < b.left && a.left > b.right)
        let vertOverlaps =
            (a.bottom < b.top && a.top > b.bottom) ||
            (a.top < b.bottom && a.bottom > b.top)
        
        return horizOverlaps && vertOverlaps
    }
}
