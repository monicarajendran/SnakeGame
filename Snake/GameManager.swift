//
//  GameManager.swift
//  Snake
//
//  Created by Monica on 26/10/19.
//  Copyright © 2019 Monica. All rights reserved.
//

import Foundation
import SpriteKit

class GameManager {
    
    var scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    func initGame() {
        scene.playerPositions.append((10, 10))
        scene.playerPositions.append((10, 11))
        scene.playerPositions.append((10, 12))
        renderChange()
    }
    
    func renderChange() {
        for (x, y) in scene.playerPositions {
            print(scene.gameArray.index(after: (20 * x) + y))
            scene.gameArray[(20 * x) + y].node.fillColor = .cyan
        }
    }
    
    func update(time: TimeInterval) {
        
    }
    
}
