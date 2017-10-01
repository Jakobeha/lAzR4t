//
//  HeartElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Each player has one of these. When destroyed, they lose the game.
class HeartElem: LiveElem {
    static let initHealth: Int = 2500
    
    let direction: PlayerDirection
    ///The amount of health this has compared to its initial health.
    var healthRatio: CGFloat {
        return CGFloat(health) / CGFloat(HeartElem.initHealth)
    }
    
    convenience init(direction: PlayerDirection, pos: CellPos, size: CellSize) {
        self.init(health: HeartElem.initHealth, direction: direction, pos: pos, size: size)
    }
    
    convenience init(direction: PlayerDirection, frame: CellFrame) {
        self.init(direction: direction, pos: frame.pos, size: frame.size)
    }
    
    init(health: Int, direction: PlayerDirection, pos: CellPos, size: CellSize) {
        self.direction = direction
        super.init(health: health, pos: pos, size: size)
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? HeartElem else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.direction == self.direction)
    }
}
