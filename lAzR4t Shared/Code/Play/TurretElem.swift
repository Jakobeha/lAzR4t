//
//  TurretElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

final class TurretElem: LiveElem_base, LiveElem, ElemToController {
    static let regInitTurretHealth: Int = 300
    
    ///The turret placeholder a player gets when they begin adding a new one.
    static func placeholder(playerDirection: PlayerDirection) -> TurretElem {
        return TurretElem(
            color: AttackColor.grey,
            direction: playerDirection.opposite.toCellDirection,
            isPlaceholder: true,
            pos: CellPos.origin
        )
    }
    
    let color: AttackColor
    let direction: CellDirection
    let isPlaceholder: Bool
    var x: Int { return pos.x }
    var y: Int { return pos.y }
    var healthRatio: CGFloat {
        return CGFloat(health) / CGFloat(TurretElem.regInitTurretHealth)
    }
    var projectile: ProjectileElem {
        return ProjectileElem(color: self.color, direction: self.direction, pos: self.pos)
    }
    
    convenience init(color: AttackColor, direction: CellDirection, isPlaceholder: Bool, pos: CellPos) {
        self.init(
            health: TurretElem.regInitTurretHealth,
            color: color,
            direction: direction,
            isPlaceholder: isPlaceholder,
            pos: pos
        )
    }
    
    init(health: Int, color: AttackColor, direction: CellDirection, isPlaceholder: Bool, pos: CellPos) {
        self.color = color
        self.direction = direction
        self.isPlaceholder = isPlaceholder
        super.init(health: health, pos: pos, size: CellSize.unit)
    }
    
    func set(health newHealth: Int) -> TurretElem {
        return TurretElem(
            health: newHealth,
            color: self.color,
            direction: self.direction,
            isPlaceholder: self.isPlaceholder,
            pos: self.pos
        )
    }
    
    func set(color newColor: AttackColor) -> TurretElem {
        return TurretElem(
            health: self.health,
            color: newColor,
            direction: self.direction,
            isPlaceholder: self.isPlaceholder,
            pos: self.pos
        )
    }
    
    func set(direction newDirection: CellDirection) -> TurretElem {
        return TurretElem(
            health: self.health,
            color: self.color,
            direction: newDirection,
            isPlaceholder: self.isPlaceholder,
            pos: self.pos
        )
    }
    
    func set(isPlaceholder newIsPlaceholder: Bool) -> TurretElem {
        return TurretElem(
            health: self.health,
            color: self.color,
            direction: self.direction,
            isPlaceholder: newIsPlaceholder,
            pos: self.pos
        )
    }
    
    override func set(pos newPos: CellPos) -> TurretElem {
        return TurretElem(
            health: self.health,
            color: self.color,
            direction: self.direction,
            isPlaceholder: self.isPlaceholder,
            pos: newPos
        )
    }
    
    override func offset(by offset: CellSize) -> TurretElem {
        return self.set(pos: self.pos + offset)
    }
    
    func makeController() -> ElemController<TurretElem> {
        return TurretElemController(curModel: self)
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? TurretElem else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.color == self.color) &&
            (other.direction == self.direction) &&
            (other.isPlaceholder == self.isPlaceholder)
    }
}
