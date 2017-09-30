//
//  GridNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit
import CoreGraphics

class GridElemNode: SKShapeNode {
    static let regFillColor: SKColor = SKColor.clear
    static let regStrokeColor: SKColor = SKColor(calibratedWhite: 0.25, alpha: 1.0)
    static let regLineWidth: CGFloat = 1

    static func path(cellFrame: CellFrame) -> CGPath {
        let curPath = CGMutablePath()
        
        let xMin = CGFloat(cellFrame.left) * CellDisplay.sideLength
        let xMax = CGFloat(cellFrame.right) * CellDisplay.sideLength
        let yMin = CGFloat(cellFrame.bottom) * CellDisplay.sideLength
        let yMax = CGFloat(cellFrame.top) * CellDisplay.sideLength
        
        //Horizontal columns
        for cellY in cellFrame.bottom...cellFrame.top { //note: includes size.height
            let y = CGFloat(cellY) * CellDisplay.sideLength
            curPath.move(to: CGPoint(x: xMin, y: y))
            curPath.addLine(to: CGPoint(x: xMax, y: y))
        }
        
        //Vertical columns
        for cellX in cellFrame.left...cellFrame.right { //note: includes size.width
            let x = CGFloat(cellX) * CellDisplay.sideLength
            curPath.move(to: CGPoint(x: x, y: yMin))
            curPath.addLine(to: CGPoint(x: x, y: yMax))
        }
        
        return curPath
    }
    
    let cellFrame: CellFrame
    var displayFrame: CGRect {
        return CGRect(
            x: cellFrame.left,
            y: cellFrame.bottom,
            width: cellFrame.width,
            height: cellFrame.height
        )
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode GridNode. Create it with init(size: CellSize)`")
    }
    
    init(cellFrame: CellFrame) {
        self.cellFrame = cellFrame
        super.init()
        self.path = GridElemNode.path(cellFrame: cellFrame)
        self.fillColor = GridElemNode.regFillColor
        self.strokeColor = GridElemNode.regStrokeColor
        self.lineWidth = GridElemNode.regLineWidth
    }
}
