//
//  Cell.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///An item, like a turret or user button.
protocol Elem {
    var frame: CellFrame { get }
    
    func set(pos: CellPos) -> Self
}

extension Elem {
    var pos: CellPos { return frame.pos }
    var size: CellSize { return frame.size }
    
    func offset(by offset: CellSize) -> Self {
        return self.set(pos: pos + offset)
    }
    
    static func overlap(_ a: Elem, _ b: Elem) -> Bool {
        return CellFrame.overlap(a.frame, b.frame)
    }
}
