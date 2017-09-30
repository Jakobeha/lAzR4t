//
//  GridNode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import SpriteKit
import CoreGraphics

class GameGridNode: SKShapeNode {
    static let regFillColor: SKColor = SKColor.clear
    static let regStrokeColor: SKColor = SKColor(calibratedWhite: 0.25, alpha: 1.0)
    static let regLineWidth: CGFloat = 1

    static func path(cellSize: CellSize) -> CGPath {
        let curPath = CGMutablePath()
        
        let xMax = CGFloat(cellSize.width) * CellDisplay.sideLength
        let yMax = CGFloat(cellSize.height) * CellDisplay.sideLength
        
        //Horizontal columns
        for cellY in 0...cellSize.height { //note: includes size.height
            let y = CGFloat(cellY) * CellDisplay.sideLength
            curPath.move(to: CGPoint(x: 0, y: y))
            curPath.addLine(to: CGPoint(x: xMax, y: y))
        }
        
        //Vertical columns
        for cellX in 0...cellSize.width { //note: includes size.width
            let x = CGFloat(cellX) * CellDisplay.sideLength
            curPath.move(to: CGPoint(x: x, y: 0))
            curPath.addLine(to: CGPoint(x: x, y: yMax))
        }
        
        return curPath
    }
    
    let cellSize: CellSize
    var displaySize: CGSize {
        return cellSize * CellDisplay.sideLength
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("Can't decode GridNode. Create it with init(size: CellSize)`")
    }
    
    init(cellSize: CellSize) {
        self.cellSize = cellSize
        super.init()
        self.path = GameGridNode.path(cellSize: cellSize)
        self.fillColor = GameGridNode.regFillColor
        self.strokeColor = GameGridNode.regStrokeColor
        self.lineWidth = GameGridNode.regLineWidth
    }
}
