//
//  FireMode.swift
//  lAzR4t
//
//  Created by Jakob Hain on 10/1/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

class FireMode: ActionMode {
    static let ticksPerSec: TimeInterval = 5
    
    let turrets: [TurretElem]
    var projectiles: [ProjectileElemController]
    var remainderTime: TimeInterval = 0
    var collidables: [PlayElemController]
    let nextMode: Mode?
    
    init(turrets: [TurretElem],
         collidables: [PlayElemController],
         nextMode: Mode?) {
        self.turrets = turrets
        projectiles = turrets.map { ProjectileElemController(curModel: $0.projectile) }
        self.collidables = collidables + projectiles
        self.nextMode = nextMode
    }
    
    private func addProjectiles(to grid: GridController<Elem>) {
        projectiles.forEach { grid.add(elem: $0.cast()) }
    }
    
    ///Moves the projectiles' through cells in the game world, given an amount of real time.
    ///Also *does* update their collisions.
    ///Returns the real time not used, which will carry over to the next update.
    private func moveProjectilesSemantic(by deltaTime: TimeInterval) -> TimeInterval {
        for _ in 0..<Int64(floor(deltaTime * FireMode.ticksPerSec)) {
            projectiles
                .sorted { $0.curModel.affectsBefore($1.curModel) }
                .forEach { projectile in
                if (projectile.isInPlay) {
                    projectile.moveOneTick(affecting: collidables)
                    collidables = collidables.filter { $0.isInPlay }
                }
            }
            projectiles = projectiles.filter { $0.isInPlay }
        }
        
        return deltaTime.truncatingRemainder(dividingBy: (1 / FireMode.ticksPerSec))
    }
    
    ///Moves the projectiles' nodes, altering how they look but not affecting gameplay mechanics.
    private func moveProjectileNodes(by deltaTime: TimeInterval) {
        let nodeOffset = CGFloat(remainderTime * FireMode.ticksPerSec)
        projectiles.forEach { $0.displayOffset = nodeOffset }
    }
    
    private func moveProjectiles(by deltaTime: TimeInterval) {
        let semDeltaTime = deltaTime + remainderTime
        remainderTime = moveProjectilesSemantic(by: semDeltaTime)
        
        moveProjectileNodes(by: deltaTime)
    }
    
    ///Removes projectiles which go out of bounds
    func removeOutOf(bounds: CellFrame) {
        projectiles.forEach { projectile in
            if !bounds.contains(center: projectile.pos) {
                projectile.removeFromPlay()
            }
        }
        
        projectiles = projectiles.filter { $0.isInPlay }
    }
    
    override func updateStart(in rootGrid: GridController<Elem>) -> [Mode] {
        addProjectiles(to: rootGrid)
        return [self]
    }
    
    override func update(by deltaTime: TimeInterval, in rootGrid: GridController<Elem>) -> [Mode] {
        guard !projectiles.isEmpty else { //Finished
            return nextMode.toArray
        }
        
        moveProjectiles(by: deltaTime)
        removeOutOf(bounds: rootGrid.curModel.bounds)
        
        return [self]
    }
}
