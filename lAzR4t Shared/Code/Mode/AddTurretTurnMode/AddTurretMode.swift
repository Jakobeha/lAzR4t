//
//  AddTurretMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///A mode which lets the player add a turret to their grid.
func AddTurretMode(playerDirection: PlayerDirection,
                   turretGrid: GridController<TurretElem>,
                   next getNextMode: @escaping (TurretElemController) -> Mode?) -> Mode {
    return PlaceTurretMode(
        playerDirection: playerDirection,
        turretGrid: turretGrid,
        next: { turret in
            RotateTurretMode(
                turret: turret,
                turretGrid: turretGrid,
                next: ColorTurretMode(turret: turret, next: getNextMode(turret))
            )
        }
    )
}
