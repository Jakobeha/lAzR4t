//
//  Mode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

///Updates the model over time, and makes it respond to user events.
protocol Mode {
    ///Returns the modes which will replace this one for future updates.
    func update(gameTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode]
    
    #if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?, in rootGrid: GridController<Elem>) -> [Mode]
    #endif
    
    #if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent, in rootGrid: GridController<Elem>) -> [Mode]
    #endif
}
