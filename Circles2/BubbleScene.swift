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
    var initialCenter: CGPoint!
    var sprite: SKSpriteNode!
    var containerNode: SKNode!
    var selectedNode: SKNode!
    var containerTouch: UITouch!
    var touchLocation: CGPoint!
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        var panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("move:"))
        self.view?.addGestureRecognizer(panRecognizer)

        
    }
    
    
    // this function takes size/string/location parameters passed in the InputTransition
    // and adds a new sprite to the Scene based on those parameters
    func addBubble(#size: CGSize, #string: String, #location: CGPoint) {
        // ignore the error stating extraneous #
        
        // set a sprite with the image named "cicle"
        sprite = SKSpriteNode(imageNamed:"circle")
        
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
        sprite.physicsBody?.mass = 0
        
        // specifying that the sprite is a circle that reacts with other sprites
        // with some physics
        sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.size.width/2.4)
        sprite.physicsBody!.dynamic = true
        sprite.userInteractionEnabled = true

        // add sprite to view & then add string to the sprite
        self.addChild(sprite)
        sprite.addChild(myLabel)


        
    }
    
 
    func move(sender: UIPanGestureRecognizer){
        
        var translation = sender.translationInView(view!)
        
        if sender.state == UIGestureRecognizerState.Began {
        
            
            initialCenter = sprite.position
            
            println("initial center: \(initialCenter)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            
             sprite.position = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y - translation.y)

            println("sprite position changed to: \(sprite.position)")

        } else if sender.state == UIGestureRecognizerState.Ended {
            println("ended at: \(sprite.position)")

            
                    }
    }
    
    
//    func onCustomPan(sender: UIPanGestureRecognizer) {
//        var point = sender.locationInView(view)
//        var velocity = sender.velocityInView(view)
//        var translation = sender.translationInView(view!)
//
//        touchLocation = sender.locationInView(sender.view)
//        touchLocation = self.convertPointFromView(touchLocation)
//        selectedNode.position = CGPointMake(touchLocation.x, touchLocation.y);
//        
//        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
//            initialCenter = sprite.position
//            println("Gesture began at: \(point)")
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
//            
//            sprite.position = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
//            println("Gesture changed at: \(point)")
//        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
//            println("Gesture ended at: \(point)")
//        }
//    }
    
    
 }
