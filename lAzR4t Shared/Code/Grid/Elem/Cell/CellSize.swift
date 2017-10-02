//
//  GridSize.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

struct CellSize: Equatable {
    static let unit: CellSize = CellSize(width: 1, height: 1)
    
    static func +(_ a: CellSize, _ b: CellSize) -> CellSize {
        return CellSize(width: a.width + b.width, height: a.height + b.height)
    }
    
    static func -(_ a: CellSize, _ b: CellSize) -> CellSize {
        return CellSize(width: a.width - b.width, height: a.height - b.height)
    }
    
    static func *(_ a: CellSize, _ scale: Int) -> CellSize {
        return CellSize(width: a.width * scale, height: a.height * scale)
    }
    
    static func ==(_ a: CellSize, _ b: CellSize) -> Bool {
        return a.width == b.width && a.height == b.height
    }
    
    let width: Int
    let height: Int
    ///The cell direction this size goes from the origin,
    ///which is closest to the real direction
    var direction: CellDirection {
        let realDir = atan2(CGFloat(height), CGFloat(width))
        return CellDirection(closestTo: realDir)
    }
}
