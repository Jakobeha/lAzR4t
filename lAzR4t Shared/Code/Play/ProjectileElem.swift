//
//  ProjectileElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

final class ProjectileElem: PlayElem_base, PlayElem {
    ///The color of the projectile, which control its type. Can't be empty.
    let colors: List<AttackColor>
    let direction: CellDirection
    var x: Int { return pos.x }
    var y: Int { return pos.y }
    var damage: Int { return colors.damage }
    var control: Int { return colors.control }
    
    convenience init(color: AttackColor, direction: CellDirection, pos: CellPos) {
        self.init(colors: List(item: color), direction: direction, pos: pos)
    }
    
    init(colors: List<AttackColor>, direction: CellDirection, pos: CellPos) {
        self.colors = colors
        self.direction = direction
        super.init(pos: pos, size: CellSize.unit)
        
        assert(!colors.isEmpty, "Projectile needs at least one color")
    }
    
    override func set(pos newPos: CellPos) -> ProjectileElem {
        return ProjectileElem(
            colors: self.colors,
            direction: self.direction,
            pos: newPos
        )
    }
    
    func add(colors newColors: List<AttackColor>) -> ProjectileElem {
        return ProjectileElem(
            colors: newColors + self.colors,
            direction: self.direction,
            pos: self.pos
        )
    }
    
    func absorb(projectile other: ProjectileElem) -> ProjectileElem? {
        let myControl = self.control
        let otherControl = other.control
        
        if myControl > otherControl {
            return self.add(colors: other.colors)
        } else {
            return nil
        }
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? ProjectileElem else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.colors == self.colors) &&
            (other.direction == self.direction)
    }
}
