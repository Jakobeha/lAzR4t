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
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
#endif

#if os(OSX)
    // Mouse-based event handling
    func mouseDown(with event: NSEvent)
    func mouseDragged(with event: NSEvent)
    func mouseUp(with event: NSEvent)
#endif
}
