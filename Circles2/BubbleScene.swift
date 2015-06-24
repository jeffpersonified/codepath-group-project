 //
 //  BubbleScene.swift
 //  Circles2
 //
 //  Created by Rebecca Goldman on 6/13/15.
 //  Copyright (c) 2015 codepath. All rights reserved.
 //
 
 import SpriteKit
 
 class BubbleScene: SKScene {
    
    var taskBubbleLabel:SKLabelNode!
    var initialCenter: CGPoint!
    var taskBubble: SKSpriteNode!
    var panRecognizer: UIPanGestureRecognizer!
    var doubleTapRecognizer: UITapGestureRecognizer!
    var touchedNode: SKNode!
    var bubbleTexture: SKTexture!
    var i: Int = 0
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        setPanRecognizer()
        setDoubleTapRecognizer()
        bubbleTexture = SKTexture(imageNamed: "blob1")
        
    }
    
    func addTaskBubble(#size: CGSize, #string: String, #location: CGPoint) {
        
        
        taskBubble = SKSpriteNode(texture: bubbleTexture)
        addTaskBubbleToScene(size, location: location)
        updateTaskBubbleLabel(string)
        
        
        // this is where we can make the sprite do cool things
        
        // specifying that the sprite is a circle that reacts with other sprites
        // with some physics
        taskBubble.physicsBody = SKPhysicsBody(circleOfRadius: taskBubble.size.width/2)
        taskBubble.physicsBody!.dynamic = true
        taskBubble.userInteractionEnabled = true
        taskBubble.physicsBody!.allowsRotation = false
        taskBubble.physicsBody?.restitution = 0.4
        taskBubble.physicsBody?.angularDamping = 0.8
        
        
        // name tasks "task" + incrementally increasing number
        taskBubble.name = "task \(i)"
        i++
        
        // add sprite to view & then add string to the sprite
        taskBubble.addChild(taskBubbleLabel)
        self.addChild(taskBubble)
        
        
        let shrink1 = SKAction.scaleTo(0.7, duration: 0.4)
        let shrink2 = SKAction.scaleTo(0.6, duration: 0.4)
        let shrink3 = SKAction.scaleTo(0.5, duration: 0.4)
        
        // set up morphing animation for first few bubbles
        let scaleUp = SKAction.scaleTo(1.02, duration: 3)
        let scale = SKAction.scaleTo(1, duration: 1)
        let scaleDown = SKAction.scaleTo(0.98, duration: 3)
        let morph = SKAction.sequence([scaleDown, scale, scaleUp])
        let repeatMorph = SKAction.repeatActionForever(morph)
        
        var sprite1 = self.childNodeWithName("task 0")
        var sprite2 = self.childNodeWithName("task 1")
        var sprite3 = self.childNodeWithName("task 2")
        var sprite4 = self.childNodeWithName("task 3")
        var sprite5 = self.childNodeWithName("task 4")
        var sprite6 = self.childNodeWithName("task 5")
        var sprite7 = self.childNodeWithName("task 6")
        var sprite8 = self.childNodeWithName("task 7")
        var sprite9 = self.childNodeWithName("task 9")
        
        
        if self.children.count >= 4 && self.children.count < 6{
            
            sprite1?.removeAllActions()
            sprite2?.removeAllActions()
            taskBubble.removeAllActions()
            sprite1?.runAction(shrink1)
            sprite2?.runAction(shrink1)
            taskBubble.runAction(shrink1)
            
        } else if self.children.count >= 6 && self.children.count < 9 {
            
            sprite1?.removeAllActions()
            sprite2?.removeAllActions()
            sprite3?.removeAllActions()
            sprite4?.removeAllActions()
            sprite5?.removeAllActions()
            sprite1?.runAction(shrink2)
            sprite2?.runAction(shrink2)
            sprite3?.runAction(shrink2)
            sprite4?.runAction(shrink2)
            sprite5?.runAction(shrink2)
            taskBubble.runAction(shrink2)
            
            
        } else if self.children.count >= 9 {
            
            sprite1?.removeAllActions()
            sprite2?.removeAllActions()
            sprite3?.removeAllActions()
            sprite4?.removeAllActions()
            sprite5?.removeAllActions()
            sprite6?.removeAllActions()
            sprite7?.removeAllActions()
            sprite8?.removeAllActions()
            sprite1?.runAction(shrink3)
            sprite2?.runAction(shrink3)
            sprite3?.runAction(shrink3)
            sprite4?.runAction(shrink3)
            sprite5?.runAction(shrink3)
            sprite6?.runAction(shrink3)
            sprite7?.runAction(shrink3)
            sprite8?.runAction(shrink3)
            sprite9?.runAction(shrink3)
            taskBubble.runAction(shrink3)
            
            
        } else if self.children.count < 4 {
            
            taskBubble.runAction(repeatMorph)
            taskBubble = nil
            
        }
        println("\(self.children.count)")
        
        
    }
    
    func move(bubble: UIPanGestureRecognizer) {
        var translation = bubble.translationInView(view!)
        var location = bubble.locationInView(view!)
        
        // flip coordinate system so it has same coordinate system as typical ViewController
        location.y = self.view!.frame.size.height - location.y
        
        if bubble.state == UIGestureRecognizerState.Began {
            // set nodes = to the node at the touched location
            var nodes = nodesAtPoint(location)
            // assign the first touched node to "touchedNode"
            touchedNode = nodes.first as? SKNode
            // set the initial center to the position of the touched node
            initialCenter = touchedNode?.position
        } else if bubble.state == UIGestureRecognizerState.Changed {
            if initialCenter != nil {
                touchedNode.position = CGPoint(x: self.initialCenter.x + translation.x, y: self.initialCenter.y - translation.y)
            }
        } else if bubble.state == UIGestureRecognizerState.Ended {
            touchedNode = nil
        }
    }
    
    func addTaskBubbleToScene(size: CGSize, location: CGPoint) {
        taskBubble.size = CGSize(width: size.width, height: size.height)
        taskBubble.xScale = 1.0
        taskBubble.yScale = 1.0
        taskBubble.position = CGPoint(x: location.x, y: location.y - 100)
        
    }
    
    func updateTaskBubbleLabel(label: String) {
        taskBubbleLabel = SKLabelNode(fontNamed: "Helvetica Neue")
        taskBubbleLabel.fontColor = UIColor(red: 220/255, green: 181/255, blue: 110/255, alpha: 1)
        taskBubbleLabel.position.y -= 10
        taskBubbleLabel.text = label
        taskBubbleLabel.fontSize = 20
    }
    
    func setPanRecognizer() {
        panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("move:"))
        view!.addGestureRecognizer(panRecognizer)
    }
    
    func setDoubleTapRecognizer() {
        doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("didDoubleTap:"))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view!.addGestureRecognizer(doubleTapRecognizer)
    }
    
    func didDoubleTap(bubble: UITapGestureRecognizer) {
        findTaskBubble(bubble.locationInView(view!))
        removeTaskBubble()
    }
    
    func findTaskBubble(bubbleLocation: CGPoint) {
        var location = bubbleLocation
        location.y = self.view!.frame.size.height - location.y
        var nodes = nodesAtPoint(location)
        touchedNode = nodes.first as? SKNode
    }
    
    func removeTaskBubble() {
        let touchedSprite = self.touchedNode as! SKSpriteNode
        var expand = SKAction.scaleTo(1.05, duration: 0.05)
        var shrinkSlow = SKAction.scaleTo(0.5, duration: 0.10)
        var shrinkFast = SKAction.scaleTo(0.0, duration: 0.05)
        let sequence = SKAction.sequence([expand, shrinkSlow, shrinkFast])
        touchedSprite.runAction(sequence, completion: {
            touchedSprite.removeFromParent()
        })
    }
 }
 
   