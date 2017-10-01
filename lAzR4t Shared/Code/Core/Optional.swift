//
//  Option.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

extension Optional {
    var toArray: [Wrapped] {
        switch self {
        case .none:
            return []
        case .some(let wrapped):
            return [wrapped]
        }
    }
}
