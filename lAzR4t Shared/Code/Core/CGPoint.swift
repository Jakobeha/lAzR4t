//
//  CGPoint.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

extension CGPoint {
    static func +(_ a: CGPoint, _ b: CGSize) -> CGPoint {
        return CGPoint(
            x: a.x + b.width,
            y: a.y + b.height
        )
    }
    
    static func *(_ a: CGPoint, _ scale: CGFloat) -> CGPoint {
        return CGPoint(
            x: a.x * scale,
            y: a.y * scale
        )
    }
}
