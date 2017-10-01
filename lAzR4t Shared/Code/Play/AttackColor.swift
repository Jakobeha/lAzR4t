//
//  AttackColor.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///The color of a projectile or turret.
///Each color makes the projectile act a different way,
///taking more damage or combining differently.
///- Red projectiles take the most damage
///- Blue projectiles have the most control: they the combined projectile's direction the most.
///- Green projectiles take the least damage and have the least control, except for grey, but when combined they significantly strengthen the strongest projectiles' effects
///- Grey projectiles aren't actually used, but they could, and they have the absolutely least stats
enum AttackColor: Equatable {
    case red
    case green
    case blue
    case grey
    
    var damage: Int {
        switch self {
        case .red:
            return 225
        case .green:
            return 75
        case .blue:
            return 100
        case .grey:
            return 50
        }
    }
    
    var control: Int {
        switch self {
        case .red:
            return 100
        case .green:
            return 75
        case .blue:
            return 225
        case .grey:
            return 50
        }
    }
    
    var toString: String {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .grey:
            return "Grey"
        }
    }
}

extension List where T == AttackColor {
    var damage: Int {
        let reds = count(of: AttackColor.red)
        let greens = count(of: AttackColor.green)
        let blues = count(of: AttackColor.blue)
        let greys = count(of: AttackColor.grey)
        
        return
            (reds * AttackColor.red.damage * (greens + 1)) +
            (greens * AttackColor.green.damage) +
            (blues * AttackColor.blue.damage) +
            (greys * AttackColor.grey.damage)
    }
    
    var control: Int {
        let reds = count(of: AttackColor.red)
        let greens = count(of: AttackColor.green)
        let blues = count(of: AttackColor.blue)
        let greys = count(of: AttackColor.grey)
        
        return
            (reds * AttackColor.red.control) +
            (greens * AttackColor.green.control) +
            (blues * AttackColor.blue.control * (greens + 1)) +
            (greys * AttackColor.grey.damage)
    }
}

