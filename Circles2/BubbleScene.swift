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
    var panRecognizer: UIPanGestureRecognizer!

    var touchedNode: SKNode!
    
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("move:"))
        
        // need to attach this gestureRecognizer to sprite, not view. Unsure how.
        view.addGestureRecognizer(panRecognizer)
        
    }
    
    
    var i : Int = 0
    // this function takes size/string/location parameters passed in the InputTransition
    // and adds a new sprite to the Scene based on those parameters
    func addBubble(#size: CGSize, #string: String, #location: CGPoint) {
        // ignore the error stating extraneous #
        
        // set a sprite with the image named "circle"
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
        sprite.physicsBody = SKPhysicsBody(circleOfRadius:sprite.size.width/2)
        sprite.physicsBody!.dynamic = true
        sprite.userInteractionEnabled = true
        
        // name tasks "task" + incrementally increasing number
        sprite.name = "task \(i)"
        i++
        
        // add sprite to view & then add string to the sprite
        sprite.addChild(myLabel)
        
        self.addChild(sprite)
        
    }
    
    
    func move(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view!)
        var location = sender.locationInView(view!)
        
        // flip coordinate system so it has same coordinate system as typical ViewController
        location.y = self.view!.frame.size.height - location.y

            if sender.state == UIGestureRecognizerState.Began {
                
                // set nodes = to the node at the touched location
                var nodes = nodesAtPoint(location)
                println("nodesAtPoint \(nodes)")

                // assign the first touched node to "touchedNode"
                touchedNode = nodes.first as? SKNode
                
                // set the initial center to the position of the touched node
                initialCenter = touchedNode?.position
                
                println("touchedNode: \(touchedNode)")
                println("initialCenter: \(initialCenter)")
                
    
            } else if sender.state == UIGestureRecognizerState.Changed {
                
                if initialCenter != nil {
                    touchedNode.position = CGPoint(x: self.initialCenter.x + translation.x, y: self.initialCenter.y - translation.y)
                }
                
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                touchedNode = nil
            }
    }
    

    
    
 }
 
  