//
//  LazyMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

///A mode which, when first used, lazily gets another mode and uses it.
///Useful for creating cycles of modes, where one mode's next mode's ... next mode is the first mode.
///Note that this gets the mode twice, so if the getter performs any long computations,
///make them lazy inside of the getter too.
class LazyMode: Mode {
    let getter: () -> Mode?
    lazy var mode: Mode? = getter()
    //If the time mode doesn't exist, this isn't necessary
    
    init(_ getter: @escaping () -> Mode?) {
        self.getter = getter
    }
    
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.update(gameTime: gameTime, in: rootGrid) ?? []
    }
    
    #if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.touchesBegan(touches, with: event, in: rootGrid) ?? []
    }
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.touchesMoved(touches, with: event, in: rootGrid) ?? []
    }
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.touchesEnded(touches, with: event, in: rootGrid) ?? []
    }
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.touchesCancelled(touches, with: event, in: rootGrid) ?? []
    }
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.mouseDown(with: event, in: rootGrid) ?? []
    }
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.mouseDragged(with: event, in: rootGrid) ?? []
    }
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode] {
        return mode?.mouseDragged(with: event, in: rootGrid) ?? []
    }
    #endif
}
