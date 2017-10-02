//
//  ColorDropDown.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ColorDropDown {
    let buttons: [ColorButtonController]
    let controller: GridElemController<ColorButtonElem>
    
    var selectedColor: AttackColor? {
        get { return buttons.first { $0.isSelected }?.curModel.color }
    }
    
    init(_ colors: [AttackColor], at pos: CellPos) {
        buttons = colors.enumerated().map { (index, color) in
            return ColorButtonController(curModel: ColorButtonElem(
                color: color,
                isSelected: false,
                pos: CellPos(x: 0, y: index)
            ))
        }
        self.controller = GridElemController(
            //pos will be where the top item is; the menu's actual position will be from the bottom item
            pos: CellPos(x: pos.x, y: pos.y - colors.count + 1),
            size: CellSize(width: 1, height: colors.count),
            display: false
        )
        buttons.forEach(controller.grid.add)
    }
    
    func selectOne(at position: CellPos) {
        deselect()
        let buttonToSelect = buttons.first { $0.curModel.pos == position }
        buttonToSelect?.isSelected = true
    }
    
    func deselect() {
        buttons.forEach { $0.isSelected = false }
    }
}
