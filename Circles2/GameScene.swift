 //
//  GameScene.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 65;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        self.addChild(myLabel)
//        self.scaleMode = SKSceneScaleAspectFit

        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
    }
    
  
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches{
            let location = touch.locationInNode(self)
            let sprite = self.nodeAtPoint(location)
            if self.nodeAtPoint(location) == sprite {
                
                sprite.removeFromParent()
            }
        }
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(imageNamed:"circle")
//
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
////            sprite.shader = SKShader(fileNamed: "Shader1.fsh")
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//
//            sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.size.width/2)
//            sprite.physicsBody!.dynamic = true
//        
//            
//
//            self.addChild(sprite)
//            
//            
////            println("sprite count: \(sprite.count)")
//            
//            
//            
//        }
//    }
//    

    
    func addBubble(#size: CGSize) {  //also add text parameter: String

        let location = CGPoint(x: 100, y: 300)
        
        let sprite = SKSpriteNode(imageNamed:"circle")
        sprite.size = CGSize(width: size.width, height: size.height)
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        sprite.position = location
        //            sprite.shader = SKShader(fileNamed: "Shader1.fsh")
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.size.width/2)
        sprite.physicsBody!.dynamic = true
        
        self.addChild(sprite)
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
