//
//  ElemToController.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///Provides a way to create an element controller for this.
protocol ElemToController where Self: Elem {
    func makeController() -> ElemController<Self>
}
