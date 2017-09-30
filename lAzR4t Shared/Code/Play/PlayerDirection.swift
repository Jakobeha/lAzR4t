//
//  PlayerDirection.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Each player is identified by the direction their field is on.
enum PlayerDirection {
    case left
    case right
    
    static let all: [PlayerDirection] = [.left, .right]
    
    var opposite: PlayerDirection {
        switch self {
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    ///Creates a frame of the inner size anchored to this side of the outer size.
    func anchor(_ innerSize: CellSize, in outerSize: CellSize) -> CellFrame {
        switch self {
        case .left:
            return CellFrame(
                left: 0,
                bottom: (outerSize.height - innerSize.height) / 2,
                right: innerSize.width,
                top: (outerSize.height + innerSize.height) / 2
            )
        case .right:
            return CellFrame(
                left: outerSize.width - innerSize.width,
                bottom: (outerSize.height - innerSize.height) / 2,
                right: outerSize.width,
                top: (outerSize.height + innerSize.height) / 2
            )
        }
    }
    
    ///Creates a frame of the inner size anchored to this side of the outer frame.
    ///This is equivalent to anchoring to the outer frame's size,
    ///and then ofsetting by the outer frame's position.
    func anchor(_ innerSize: CellSize, in outerFrame: CellFrame) -> CellFrame {
        return anchor(innerSize, in: outerFrame.size).offset(by: outerFrame.pos.toSize)
    }
}
