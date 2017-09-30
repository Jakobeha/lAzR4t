//
//  HeartElemNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit

class HeartElemNode: ElemShapeNode {
    ///How light the heart's colors are: 0 for black and 1 for full color.
    static let colorLightness: CGFloat = 0.75
    
    static func fillColor(healthRatio: CGFloat, direction: PlayerDirection) -> SKColor {
        ///Fades from opaque (full health) to clear (no health)
        switch direction {
        case .left:
            return SKColor(
                calibratedRed: HeartElemNode.colorLightness,
                green: 0,
                blue: 0,
                alpha: healthRatio
            )
        case .right:
            return SKColor(
                calibratedRed: 0,
                green: 0,
                blue: HeartElemNode.colorLightness,
                alpha: healthRatio
            )
        }
    }
    
    static func path(cellFrame: CellFrame, direction: PlayerDirection) -> CGPath {
        let curPath = CGMutablePath()
        switch direction {
        case .left:
            curPath.move(to: CellPos(x: cellFrame.left, y: cellFrame.top).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.right - 1, y: cellFrame.top).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.right, y: cellFrame.top - 1).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.right, y: cellFrame.bottom + 1).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.right - 1, y: cellFrame.bottom).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.left, y: cellFrame.bottom).toDisplay)
            curPath.closeSubpath()
            break
        case .right:
            curPath.move(to: CellPos(x: cellFrame.right, y: cellFrame.top).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.left + 1, y: cellFrame.top).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.left, y: cellFrame.top - 1).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.left, y: cellFrame.bottom + 1).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.left + 1, y: cellFrame.bottom).toDisplay)
            curPath.addLine(to: CellPos(x: cellFrame.right, y: cellFrame.bottom).toDisplay)
            curPath.closeSubpath()
            break
        }
        return curPath
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError(
            "Can't decode HeartElemNode. " +
            "Create it with init(healthRatio: CGFloat, cellFrame: CellFrame, direction: CellDirection)`"
        )
    }
    
    init(healthRatio: CGFloat, direction: PlayerDirection, cellFrame: CellFrame) {
        super.init()
        reconfigure(healthRatio: healthRatio, direction: direction, cellFrame: cellFrame)
    }
    
    func reconfigure(healthRatio: CGFloat, direction: PlayerDirection, cellFrame: CellFrame) {
        path = HeartElemNode.path(cellFrame: cellFrame, direction: direction)
        fillColor = HeartElemNode.fillColor(healthRatio: healthRatio, direction: direction)
        strokeColor = SKColor.clear
    }
}
