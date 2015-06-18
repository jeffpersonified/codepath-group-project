 //
//  BubbleScene.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import SpriteKit

class BubbleScene: SKScene {
    
    var myLabel:SKLabelNode!

    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        
    }
    
    
    // this function takes size/string/location parameters passed in the InputTransition
    // and adds a new sprite to the Scene based on those parameters
    func addBubble(#size: CGSize, #string: String, #location: CGPoint) {
        // ignore the error stating extraneous #

        
        // set a sprite with the image named "cicle"
        let sprite = SKSpriteNode(imageNamed:"circle")
        
        // set the sprite's size to the "size" parameter passed in InputTransition
        sprite.size = CGSize(width: size.width, height: size.height)
        sprite.xScale = 1.0
        sprite.yScale = 1.0
        
        sprite.position = location
        // due to gravity, sprite automatically falls to bottom of screen

        // create a label that will take the "string" parameter passed in InputTransition
        myLabel = SKLabelNode(fontNamed: "Helvetica Neue")
        myLabel.fontColor = UIColor.whiteColor()
        myLabel.text = string
        myLabel.fontSize = 17
        
        // this is where we can make the sprite do cool things
        var action = SKAction.scaleTo(0.8, duration: 0.6)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        // specifying that the sprite is a circle that reacts with other sprites 
        // with some physics
        sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.size.width/2)
        sprite.physicsBody!.dynamic = true
        
        // add sprite to view & then add string to the sprite
        self.addChild(sprite)
        sprite.addChild(myLabel)

    }

}
