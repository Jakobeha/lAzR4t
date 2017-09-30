//
//  TimeMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Updates the model over time.
protocol TimeMode {
    var baseTime: TimeInterval { get }
    
    func update(liveTime: TimeInterval)
}

extension TimeMode {
    func update(gameTime: TimeInterval) {
        update(liveTime: gameTime - baseTime)
    }
}
