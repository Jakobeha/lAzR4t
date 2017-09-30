//
//  GridNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit
import CoreGraphics

class GridElemNode: ElemShapeNode {
    static let regFillColor: SKColor = SKColor.clear
    static let regStrokeColor: SKColor = SKColor(calibratedWhite: 0.25, alpha: 1.0)
    static let regLineWidth: CGFloat = 1

    static func path(cellSize: CellSize) -> CGPath {
        let curPath = CGMutablePath()
        
        let xMin = 0 as CGFloat
        let yMin = 0 as CGFloat
        let xMax = cellSize.width.toDisplay
        let yMax = cellSize.height.toDisplay
        
        //Horizontal columns
        for cellY in 0...cellSize.height { //note: includes size.height
            let y = cellY.toDisplay
            curPath.move(to: CGPoint(x: xMin, y: y))
            curPath.addLine(to: CGPoint(x: xMax, y: y))
        }
        
        //Vertical columns
        for cellX in 0...cellSize.width { //note: includes size.width
            let x = cellX.toDisplay
            curPath.move(to: CGPoint(x: x, y: yMin))
            curPath.addLine(to: CGPoint(x: x, y: yMax))
        }
        
        return curPath
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode GridElemNode. Create it with init(frame: CellFrame)`")
    }
    
    init(cellSize: CellSize) {
        super.init()
        fillColor = GridElemNode.regFillColor
        strokeColor = GridElemNode.regStrokeColor
        lineWidth = GridElemNode.regLineWidth
        reconfigure(cellSize: cellSize)
    }
    
    func reconfigure(cellSize: CellSize) {
        path = GridElemNode.path(cellSize: cellSize)
    }
}
