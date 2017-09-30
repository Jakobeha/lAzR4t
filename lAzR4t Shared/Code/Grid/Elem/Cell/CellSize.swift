//
//  GridSize.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

struct CellSize {
    static let unit: CellSize = CellSize(width: 1, height: 1)
    
    let width: Int
    let height: Int
    
    static func +(_ a: CellSize, _ b: CellSize) -> CellSize {
        return CellSize(width: a.width + b.width, height: a.height + b.height)
    }
    
    static func -(_ a: CellSize, _ b: CellSize) -> CellSize {
        return CellSize(width: a.width - b.width, height: a.height - b.height)
    }
    
    static func *(_ a: CellSize, _ scale: Int) -> CellSize {
        return CellSize(width: a.width * scale, height: a.height * scale)
    }
}
