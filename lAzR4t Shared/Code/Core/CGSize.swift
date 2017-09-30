//
//  CGSize.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

extension CGSize {
    static func +(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(
            width: a.width + b.width,
            height: a.height + b.height
        )
    }
}
