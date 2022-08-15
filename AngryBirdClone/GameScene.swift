//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Alperen Kavuk on 13.08.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
   // var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    var box7 = SKSpriteNode()
    var gameStarted = false
    var originalPosition: CGPoint?
    enum ColliderType: UInt32{
        case bird = 1
        case box = 2
        
    }
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
   /*     let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y:  0)
        bird2.size = CGSize(width: 60 , height: 60)
        bird2.zPosition = 1
        self.addChild(bird2)
      */
        //ekran sınırı
         self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
         self.scene?.scaleMode = .aspectFit
         self.physicsWorld.contactDelegate = self
   //bird
        bird = childNode(withName: "bird") as! SKSpriteNode

        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 25)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
    
    //fiziksel temas
        bird.physicsBody?.contactTestBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.box.rawValue

    //box
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 10, height: boxTexture.size().height / 10)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.10
        
        box1.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.10
        
        box2.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.10
    
        box3.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.10
        
        box4.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.10
        
        box5.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        box6.physicsBody = SKPhysicsBody(rectangleOf: size)
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.allowsRotation = true
        box6.physicsBody?.mass = 0.10
    
        box6.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        box7 = childNode(withName: "box7") as! SKSpriteNode
        box7.physicsBody = SKPhysicsBody(rectangleOf: size)
        box7.physicsBody?.affectedByGravity = true
        box7.physicsBody?.isDynamic = true
        box7.physicsBody?.allowsRotation = true
        box7.physicsBody?.mass = 0.10
        
        box7.physicsBody?.collisionBitMask = ColliderType.bird.rawValue
        
        //label oluşturmak
        scoreLabel.fontName = "helvetica"
        scoreLabel.fontSize = 50
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.bird.rawValue{
            score += 1
            scoreLabel.text = String(score)
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* kuşu uçurma
        bird.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 100))
        bird.physicsBody?.affectedByGravity = true
        */
        if gameStarted == false {
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes{
                        if let  sprite = node as? SKSpriteNode {
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes{
                        if let  sprite = node as? SKSpriteNode {
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes{
                        if let  sprite = node as? SKSpriteNode {
                            if sprite == bird{
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: 10*dx, dy: 10*dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let birdPhysicBody = bird.physicsBody {
            if birdPhysicBody.velocity.dy <= 0 && birdPhysicBody.velocity.dy <= 0 && birdPhysicBody.angularVelocity <= 0 && gameStarted == true{
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.angularVelocity = 0
                bird.position = originalPosition!
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.zPosition = 1
                
                score = 0
                scoreLabel.text = String(score)
                gameStarted = false
                
            }
        }
        
    }
}
