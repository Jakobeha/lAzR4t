//
//  ActionMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

///A Mode which doesn't typically involve control, but animations and time updates.
class ActionMode: Mode {
    private var lastTime: TimeInterval = TimeInterval.nan
    
    ///Called when the mode starts updating, before it gets a delta update.
    func updateStart(in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    
    func update(by deltaTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    
    ///Returns the modes which will replace this one for future updates.
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        guard !lastTime.isNaN else {
            lastTime = gameTime
            return updateStart(in: rootGrid)
        }
            
        let nextMode = update(by: gameTime - lastTime, in: rootGrid)
        lastTime = gameTime
        return nextMode
    }
    
    #if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return [self]
    }
    #endif
}
