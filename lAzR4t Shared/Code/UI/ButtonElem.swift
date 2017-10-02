//
//  ButtonElem.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ButtonElem: Elem {
    ///Whether the player is highlighting or selecting the button.
    let isSelected: Bool
    init(isSelected: Bool, pos: CellPos, size: CellSize) {
        self.isSelected = isSelected
        super.init(pos: pos, size: size)
    }
    
    func set(isSelected newIsSelected: Bool) -> ButtonElem {
        return ButtonElem(isSelected: newIsSelected, pos: self.pos, size: self.size)
    }
}
