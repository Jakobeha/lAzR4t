//
//  ColorButtonElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///A button which represents color
final class ColorButtonElem: ButtonElem {
    let color: AttackColor
    
    init(color: AttackColor, isSelected: Bool, pos: CellPos) {
        self.color = color
        super.init(isSelected: isSelected, pos: pos, size: CellSize.unit)
    }
    
    override func set(pos newPos: CellPos) -> ColorButtonElem {
        return ColorButtonElem(
            color: self.color,
            isSelected: self.isSelected,
            pos: newPos
        )
    }
    
    override func set(isSelected newIsSelected: Bool) -> ColorButtonElem {
        return ColorButtonElem(
            color: self.color,
            isSelected: newIsSelected,
            pos: self.pos
        )
    }
    
    override func equals(_ other: Elem) -> Bool {
        guard let other = other as? ColorButtonElem else {
            return false
        }
        
        return
            super.equals(other) &&
            (other.color == self.color) &&
            (other.isSelected == self.isSelected)
    }
}
