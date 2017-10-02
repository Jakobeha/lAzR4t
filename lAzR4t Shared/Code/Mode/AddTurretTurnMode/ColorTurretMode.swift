//
//  ColorTurretMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

class ColorTurretMode: Mode {
    private let turret: TurretElemController
    private var curDropDown: ColorDropDown?
    private let nextMode: Mode?
    
    init(turret: TurretElemController, next nextMode: Mode?) {
        self.turret = turret
        self.curDropDown = nil
        self.nextMode = nextMode
    }
    
    func selectOne(at selectPos: CellPos) {
        curDropDown!.selectOne(at: selectPos)
        turret.color = curDropDown!.selectedColor ?? AttackColor.grey
    }
    
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    
    #if os(iOS) || os(tvOS)
    //Note: Won't work on multitouch, since multiple began-end events can happen for multiple touches
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let dropDownPos = event.location(in: rootGrid)
        curDropDown = ColorDropDown([
            AttackColor.red,
            AttackColor.green,
            AttackColor.blue
        ], at: dropDownPos)
        rootGrid.add(elem: curDropDown!.controller.cast())
        selectOne(at: dropDownPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let selectPos = event.location(in: curDropDown!.controller)
        selectOne(at: selectPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let selectPos = event.location(in: curDropDown!.controller)
        selectOne(at: selectPos)
        rootGrid.remove(elem: curDropDown!.controller.cast())
        curDropDown = nil
        if turret.color != AttackColor.grey { //A color was selected
            return nextMode.toArray
        } else {
            return [self]
        }
    }
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        try! rootGrid.removeOne(elem: curDropDown!.controller)
        curDropDown = nil
        return [self]
    }
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let dropDownPos = event.location(in: rootGrid)
        curDropDown = ColorDropDown([
            AttackColor.red,
            AttackColor.green,
            AttackColor.blue
        ], at: dropDownPos)
        rootGrid.add(elem: curDropDown!.controller.cast())
        selectOne(at: dropDownPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let selectPos = event.location(in: curDropDown!.controller)
        selectOne(at: selectPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let selectPos = event.location(in: curDropDown!.controller)
        selectOne(at: selectPos)
        try! rootGrid.removeOne(elem: curDropDown!.controller.cast())
        curDropDown = nil
        if turret.color != AttackColor.grey { //A color was selected
            return nextMode.toArray
        } else {
            return [self]
        }
    }
    #endif
}

