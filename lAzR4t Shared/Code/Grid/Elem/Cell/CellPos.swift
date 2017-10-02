//
//  IntPos.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

struct CellPos: Equatable {
    static let origin: CellPos = CellPos(x: 0, y: 0)
    
    static func +(_ a: CellPos, _ b: CellSize) -> CellPos {
        return CellPos(x: a.x + b.width, y: a.y + b.height)
    }
    
    static func -(_ a: CellPos, _ b: CellSize) -> CellPos {
        return CellPos(x: a.x - b.width, y: a.y - b.height)
    }
    
    static func -(_ a: CellPos, _ b: CellPos) -> CellSize {
        return CellSize(width: a.x - b.x, height: a.y - b.y)
    }
    
    static func ==(_ a: CellPos, _ b: CellPos) -> Bool {
        return a.x == b.x && a.y == b.y
    }
    
    let x: Int
    let y: Int
    
    var toSize: CellSize {
        return CellSize(width: x, height: y)
    }
    
    func direction(of other: CellPos) -> CellDirection {
        return (other - self).direction
    }
    
    ///How far this point is from the origin, *in the direction specified*.
    ///Examples:
    ///- `(3, 3).distanceFromOrigin(in: upRight)` is 3
    ///- `(3, 3).distanceFromOrigin(in: downLeft)` is -3
    ///- `(3, 3).distanceFromOrigin(in: downRight)` is 0
    ///- `(3, 2).distanceFromOrigin(in: upRight)` is 2.5
    func distanceFromOrigin(in direction: CellDirection) -> CGFloat {
        switch direction {
        case .right:
            return CGFloat(self.x)
        case .upRight:
            return CGFloat(self.x + self.y) / 2
        case .up:
            return CGFloat(self.y)
        case .upLeft:
            return CGFloat(-self.x + self.y) / 2
        case .left:
            return CGFloat(-self.x)
        case .downLeft:
            return CGFloat(-self.x - self.y) / 2
        case .down:
            return CGFloat(-self.y)
        case .downRight:
            return CGFloat(self.x - self.y) / 2
        }
    }
}
