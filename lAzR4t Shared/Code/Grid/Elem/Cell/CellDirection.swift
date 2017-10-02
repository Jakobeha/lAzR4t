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
    
    var isDiagonal: Bool {
        switch self {
        case .up:
            return false
        case .upRight:
            return true
        case .right:
            return false
        case .downRight:
            return true
        case .down:
            return false
        case .downLeft:
            return true
        case .left:
            return false
        case .upLeft:
            return true
        }
    }
    
    init(closestTo realDir: CGFloat) {
        switch realDir {
        case (CGFloat.pi * -0.125)..<(CGFloat.pi * 0.125):
            self = .right
        case (CGFloat.pi * 0.125)..<(CGFloat.pi * 0.375):
            self = .upRight
        case (CGFloat.pi * 0.375)..<(CGFloat.pi * 0.625):
            self = .up
        case (CGFloat.pi * 0.625)..<(CGFloat.pi * 0.875):
            self = .upLeft
        case (CGFloat.pi * 0.875)...CGFloat.pi:
            self = .left
        case (-CGFloat.pi)..<(CGFloat.pi * -0.875):
            self = .left
        case (CGFloat.pi * -0.875)..<(CGFloat.pi * -0.625):
            self = .downLeft
        case (CGFloat.pi * -0.625)..<(CGFloat.pi * -0.375):
            self = .down
        case (CGFloat.pi * -0.375)..<(CGFloat.pi * -0.125):
            self = .downRight
        default:
            if (realDir < 0) {
                self = CellDirection(closestTo: realDir + (CGFloat.pi * 2))
            } else {
                self = CellDirection(closestTo: realDir - (CGFloat.pi * 2))
            }
        }
    }
    
    func offset(magnitude: Int) -> CellSize {
        return unitOffset * magnitude
    }
}
