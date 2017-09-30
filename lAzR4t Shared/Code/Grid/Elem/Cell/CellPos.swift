//
//  IntPos.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

struct CellPos {
    static let origin: CellPos = CellPos(x: 0, y: 0)
    
    let x: Int
    let y: Int
    
    static func +(_ a: CellPos, _ b: CellSize) -> CellPos {
        return CellPos(x: a.x + b.width, y: a.y + b.height)
    }
    
    static func -(_ a: CellPos, _ b: CellSize) -> CellPos {
        return CellPos(x: a.x - b.width, y: a.y - b.height)
    }
    
    static func -(_ a: CellPos, _ b: CellPos) -> CellSize {
        return CellSize(width: a.x - b.x, height: a.y - b.y)
    }
}
