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
