//
//  GameScene.swift
//  Snake
//
//  Created by Monica on 25/10/19.
//  Copyright © 2019 Monica. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var logo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!
    
    var currentScore: SKLabelNode!
    var gameBG: SKShapeNode!
    
    var gameManager: GameManager!
    var gameArray: [(node: SKShapeNode, x: Int, y: Int)] = []
    
    typealias Position = (Int, Int)
    var playerPositions: [Position] = []
    
    private func initialize() {
        initLogo()
        initBestScore()
        initPlayButton()
    }
    
    override func didMove(to view: SKView) {
        initialize()
        initGameView()
        gameManager = GameManager(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameManager.update(time: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNode = self.nodes(at: location)
            
            for node in touchNode {
                if node.name == "play_button" {
                    self.startGame()
                }
            }
        }
    }
    
    func initLogo() {
        logo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        logo.zPosition = 1 //
        logo.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 200)
        logo.fontSize = 100
        logo.text = "SNAKE"
        logo.fontColor = SKColor.red
        self.addChild(logo)
    }
    
    func initBestScore() {
        bestScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        bestScore.zPosition = 1 //
        bestScore.position = CGPoint(x: frame.size.width / 2, y: logo.position.y - 100)
        bestScore.fontSize = 40
        bestScore.text = "Best Score: 0"
        bestScore.fontColor = SKColor.white
        self.addChild(bestScore)
    }
    
    func initPlayButton() {
        playButton = SKShapeNode()
        playButton.zPosition = 1 //
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        playButton.name = "play_button"
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -70, y: 70)
        let bottomCorner = CGPoint(x: -70, y: -70)
        let middle = CGPoint(x: 70, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
    }
    
    func initCurrentScore() {
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.zPosition = 1
        currentScore.position = CGPoint(x: frame.size.width / 2, y: 30)
        currentScore.fontSize = 50
        currentScore.text = "Score: 0"
        currentScore.fontColor = SKColor.white
        currentScore.isHidden = true
        self.addChild(currentScore)
    }
    
    func prepareForGame() {
        
        //Logo
        logo.run(SKAction.moveBy(x: 0, y: 600, duration: 0.5)) {
            self.logo.isHidden = true
        }
        //Play button
        playButton.run(SKAction.scale(to: 0, duration: 0.3)) {
            self.playButton.isHidden = true
        }
        //Best score
        let bottomCorner = CGPoint(x: frame.size.width / 2, y: -600)
        bestScore.run(SKAction.move(to: bottomCorner, duration: 0.5)) {
            self.gameBG.setScale(0)
            self.currentScore.setScale(0)
            self.gameBG.isHidden = false
            self.currentScore.isHidden = false
            self.gameBG.run(SKAction.scale(to: 1, duration: 0.4))
            self.currentScore.run(SKAction.scale(to: 1, duration: 0.4))
            self.gameManager.initGame()
        }
    }
    
    func initGameView() {
        let width = frame.size.width - 60
        let numberOfColomns = 20
        let numberOfRows = 30
        let cellSize = width / CGFloat(numberOfColomns)
        let height = CGFloat(numberOfRows) * cellSize
        
        gameBG = SKShapeNode(rectOf: CGSize(width: width, height: height))
        gameBG.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        gameBG.fillColor = SKColor.darkGray
        gameBG.zPosition = 2
        gameBG.isHidden = true
        addChild(gameBG)
        createGameBoard(width: width, height: height, cellSize: cellSize)
    }
    
    func createGameBoard(width: CGFloat, height: CGFloat, cellSize: CGFloat) {
    
        var x: CGFloat = -width / 2 + cellSize / 2
        var y: CGFloat = height / 2 - cellSize / 2
        //loop through rows and columns, create cells
        for i in 0..<30 {
            for j in 0..<20{
                let cellNode = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
                cellNode.strokeColor = SKColor.black
                cellNode.zPosition = 2
                cellNode.position = CGPoint(x: x, y: y)
                //add to array of cells -- then add to game board
                gameArray.append((node: cellNode, x: j, y: i))
                gameBG.addChild(cellNode)
                //iterate x
                x += cellSize
            }
            //reset x, iterate y
            x = CGFloat(width / -2) + (cellSize / 2)
            y -= cellSize
        }
    }
    
    func startGame() {
        initCurrentScore()
        prepareForGame()
    }
}
