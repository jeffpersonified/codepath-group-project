 //
//  BubbleScene.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import SpriteKit

class BubbleScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
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


    
    func addBubble(#size: CGSize) {  //also add text parameter: String

        let location = CGPoint(x: 100, y: 300)
        
        let sprite = SKSpriteNode(imageNamed:"circle")
        sprite.size = CGSize(width: size.width, height: size.height)
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        sprite.position = location
        
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
