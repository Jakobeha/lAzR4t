//
//  Mode.swift
//  lAzR4t iOS
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

///Lets the user control the model -- handles the user's events and affects the model.
protocol ControlMode {
#if os(iOS) || os(tvOS)
    // Touch-based event handling
    ///Returns the modes which will replace this one for future events.
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) -> [Mode]
#endif

#if os(OSX)
    // Mouse-based event handling
    ///Returns the modes which will replace this one for future events.
    func mouseDown(with event: NSEvent) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func mouseDragged(with event: NSEvent) -> [Mode]
    ///Returns the modes which will replace this one for future events.
    func mouseUp(with event: NSEvent) -> [Mode]
#endif
}
