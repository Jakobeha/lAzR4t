//
//  CellDirection.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

enum CellDirection {
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
    case upLeft
    
    var unitOffset: CellSize {
        switch self {
        case .up:
            return CellSize(width: 0, height: 1)
        case .upRight:
            return CellSize(width: 1, height: 1)
        case .right:
            return CellSize(width: 1, height: 0)
        case .downRight:
            return CellSize(width: 1, height: -1)
        case .down:
            return CellSize(width: 0, height: -1)
        case .downLeft:
            return CellSize(width: -1, height: -1)
        case .left:
            return CellSize(width: -1, height: 0)
        case .upLeft:
            return CellSize(width: -1, height: 1)
        }
    }
    
    func offset(magnitude: Int) -> CellSize {
        return unitOffset * magnitude
    }
}
