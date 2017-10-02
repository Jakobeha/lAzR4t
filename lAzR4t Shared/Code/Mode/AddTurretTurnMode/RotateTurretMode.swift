//
//  RotateTurretMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

class RotateTurretMode: Mode {
    private let turret: TurretElemController
    private let turretGrid: GridController<TurretElem>
    private let nextMode: Mode?
    
    init(turret: TurretElemController, turretGrid: GridController<TurretElem>, next nextMode: Mode?) {
        self.turret = turret
        self.turretGrid = turretGrid
        self.nextMode = nextMode
    }
    
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    
    #if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(to: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(to: newPos)
        return nextMode.toArray
    }
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
    
    }
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(of: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(of: newPos)
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        let newPos = event.location(in: turretGrid)
        turret.direction = turret.pos.direction(of: newPos)
        return nextMode.toArray
    }
    #endif
}
