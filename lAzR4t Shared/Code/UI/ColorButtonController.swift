//
//  ColorButtonController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class ColorButtonController: SimpleElemController<ColorButtonElem> {
    override var curModel: ColorButtonElem {
        didSet {
            node_spe.reconfigure(
                color: curModel.color,
                isSelected: curModel.isSelected,
                pos: curModel.pos
            )
        }
    }
    let node_spe: ColorButtonNode
    var isSelected: Bool {
        get { return curModel.isSelected }
        set(newIsSelected) { curModel = curModel.set(isSelected: newIsSelected) }
    }
    
    init(curModel: ColorButtonElem) {
        node_spe = ColorButtonNode(
            color: curModel.color,
            isSelected: curModel.isSelected,
            pos: curModel.pos
        )
        super.init(curModel: curModel, node: node_spe)
    }
}
