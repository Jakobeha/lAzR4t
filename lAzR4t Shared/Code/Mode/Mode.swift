//
//  Mode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class Mode {
    let controlMode: ControlMode?
    let timeMode: TimeMode?
    
    init(controlMode: ControlMode, timeMode: TimeMode) {
        self.controlMode = controlMode
        self.timeMode = timeMode
    }
}
