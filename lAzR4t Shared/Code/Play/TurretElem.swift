//
//  TurretElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

final class TurretElem: LiveElem, ElemToController {
    static let regInitTurretHealth: Int = 500
    
    let color: AttackColor
    let direction: CellDirection
    var x: Int { return pos.x }
    var y: Int { return pos.y }
    
    convenience init(color: AttackColor, direction: CellDirection, pos: CellPos) {
        self.init(
            health: TurretElem.regInitTurretHealth,
            color: color,
            direction: direction,
            pos: pos
        )
    }
    
    init(health: Int, color: AttackColor, direction: CellDirection, pos: CellPos) {
        self.color = color
        self.direction = direction
        super.init(health: health, pos: pos, size: CellSize.unit)
    }
    
    func makeController() -> ElemController<TurretElem> {
        return TurretElemController(curModel: self)
    }
}
