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
    var array = [0, 1, 2, 3, 4, 5, 6]
    var spriteArray: [SKSpriteNode] = [SKSpriteNode]()
    var panRecognizer: UIPanGestureRecognizer!
    var circle: UIImageView!
    var spriteView: SKView!
    var start: CGPoint!
    var end: CGPoint!
    
    var touchLocation: CGPoint!
    var touchedNode: SKNode!
    var touch: UITouch!
    
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("move:"))
        
        // need to attach this gestureRecognizer to sprite, not view. Unsure how.
        view.addGestureRecognizer(panRecognizer)
        
    }
    
    
    
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
        sprite.name = "task"
        
        
        // add sprite to view & then add string to the sprite
        sprite.addChild(myLabel)
        
        self.addChild(sprite)
        
        // add all sprites to an array of sprites
        spriteArray.append(sprite)
        
    }
    
    
    func move(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view!)
        
        // attempt to move selected sprite
        for sprite in spriteArray {
            
            if sender.state == UIGestureRecognizerState.Began {
                
                self.initialCenter = self.sprite.position
                
                println("initial center: \(self.initialCenter)")
            } else if sender.state == UIGestureRecognizerState.Changed {
                
                self.sprite.position = CGPoint(x: self.initialCenter.x + translation.x, y: self.self.initialCenter.y - translation.y)
                
                println("sprite position changed to: \(self.sprite.position)")
                
            } else if sender.state == UIGestureRecognizerState.Ended {
                println("ended at: \(self.sprite.position)")
                
                
            }
        }
    }
    
    
    //    override func touchesBegan(touches: Set<NSObject>,
    //        withEvent event: UIEvent?) {
    //                for touch in (touches as! Set<UITouch>) {
    //                    touchLocation = touch.locationInNode(self)
    //                    touchedNode = nodeAtPoint(touchLocation)
    //                    println("touched node: \(touchedNode)")
    //                }
    //    }
    //
    
    
 }
 
  