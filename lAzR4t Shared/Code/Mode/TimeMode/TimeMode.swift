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
    
    ///Returns the modes which will replace this one for future updates.
    func update(liveTime: TimeInterval) -> [Mode]
}

extension TimeMode {
    ///Returns the modes which will replace this one for future updates.
    func update(gameTime: TimeInterval) -> [Mode] {
        return update(liveTime: gameTime - baseTime)
    }
}
