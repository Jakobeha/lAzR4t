//
//  PlaceTurretMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

class PlaceTurretMode: Mode {
    private let turretGrid: GridController<TurretElem>
    private let getNextMode: (TurretElemController) -> Mode?
    private let placeholder: TurretElemController
    
    init(playerDirection: PlayerDirection,
         turretGrid: GridController<TurretElem>,
         next getNextMode: @escaping (TurretElemController) -> Mode?) {
        self.turretGrid = turretGrid
        self.getNextMode = getNextMode
        self.placeholder = TurretElemController(curModel: TurretElem.placeholder(playerDirection: playerDirection))
    }
    
    func bringPlaceholder(to newPos: CellPos) {
        if posAvailable(newPos) {
            if !turretGrid.curElems.contains(placeholder) {
                turretGrid.add(elem: placeholder)
            }
            placeholder.pos = newPos
        } else {
            removePlaceholder()
        }
    }
    
    func posAvailable(_ newPos: CellPos) -> Bool {
        return
            turretGrid.curModel.bounds.contains(center: newPos) &&
            !turretGrid.curModel.elems.contains { $0.pos == newPos && !$0.isPlaceholder }
    }
    
    func tryPlacePlaceholder(at newPos: CellPos) -> Bool {
        if posAvailable(newPos) {
            if !turretGrid.curElems.contains(placeholder) {
                turretGrid.add(elem: placeholder)
            }
            placeholder.pos = newPos
            return true
        } else {
            removePlaceholder()
            return false
        }
    }
    
    func removePlaceholder() {
        if (turretGrid.curElems.contains(placeholder)) {
            try! turretGrid.removeOne(elem: placeholder)
        }
    }
    
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    
    #if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        bringPlaceholder(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        bringPlaceholder(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        if tryPlacePlaceholder(at: newPos) {
            placeholder.isPlaceholder = false
            let nextMode = getNextMode(placeholder)
            return nextMode.toArray
        } else {
            return [self]
        }
    }
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        removePlaceholder()
        return [self]
    }
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        bringPlaceholder(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        bringPlaceholder(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        if tryPlacePlaceholder(at: newPos) {
            placeholder.isPlaceholder = false
            let nextMode = getNextMode(placeholder)
            return nextMode.toArray
        } else {
            return [self]
        }
    }
    #endif
}
