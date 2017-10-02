//
//  NSEvent.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import EventKit

#if os(iOS) || os(tvOS)
typealias Event = UIEvent
#endif
#if os(OSX)
typealias Event = NSEvent
#endif

extension Event {
    func location<TElem>(in elem: GridController<TElem>) -> CellPos {
        return CellPos(fromDisplay: location(in: elem.node))
    }
    
    func location<TElem>(in elem: GridElemController<TElem>) -> CellPos {
        return location(in: elem.grid)
    }
}
