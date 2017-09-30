//
//  CellDisplay.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class CellDisplay {
    static let sideLength: CGFloat = 96
}

func *(_ a: CellPos, _ scale: CGFloat) -> CGPoint {
    return CGPoint(
        x: CGFloat(a.x) * scale,
        y: CGFloat(a.y) * scale
    )
}

extension Int {
    var toDisplay: CGFloat {
        return CGFloat(self) * CellDisplay.sideLength
    }
}

extension CellPos {
    var toDisplay: CGPoint {
        return self * CellDisplay.sideLength
    }
}

func *(_ a: CellSize, _ scale: CGFloat) -> CGSize {
    return CGSize(
        width: CGFloat(a.width) * scale,
        height: CGFloat(a.height) * scale
    )
}

extension CellSize {
    var toDisplay: CGSize {
        return self * CellDisplay.sideLength
    }
}

func *(_ a: CellFrame, _ scale: CGFloat) -> CGRect {
    return CGRect(
        x: CGFloat(a.left) * scale,
        y: CGFloat(a.bottom) * scale,
        width: CGFloat(a.width) * scale,
        height: CGFloat(a.height) * scale
    )
}

extension CellFrame {
    var toDisplay: CGRect {
        return self * CellDisplay.sideLength
    }
}

extension CellDirection {
    var toRotation: CGFloat {
        switch self {
        case .up:
            return CGFloat.pi / 2
        case .upRight:
            return CGFloat.pi / 4
        case .right:
            return 0
        case .downRight:
            return CGFloat.pi / -4
        case .down:
            return CGFloat.pi / -2
        case .downLeft:
            return CGFloat.pi * -0.75
        case .left:
            return CGFloat.pi
        case .upLeft:
            return CGFloat.pi * 0.75
        }
    }
    
    func displayOffset(in magnitude: CGFloat) -> CGSize {
        let displayUnitOffset = unitOffset.toDisplay
        return CGSize(
            width: displayUnitOffset.width * magnitude,
            height: displayUnitOffset.height * magnitude
        )
    }
}
