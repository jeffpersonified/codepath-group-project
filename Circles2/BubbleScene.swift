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
    var i : Int = 0
    
    override func didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        setPanRecognizer()
        setDoubleTapRecognizer()
    }
    
    // this function takes size/string/location parameters passed in the InputTransition
    // and adds a new sprite to the Scene based on those parameters
    func addTaskBubble(#size: CGSize, #string: String, #location: CGPoint) {
        taskBubble = SKSpriteNode(imageNamed: "circle")
        addTaskBubbleToScene(size, location: location)
        updateTaskBubbleLabel(string)

        // this is where we can make the sprite do cool things
        var action = SKAction.scaleTo(1.0, duration: 0.6)
        taskBubble.runAction(SKAction.repeatActionForever(action))
        taskBubble.physicsBody?.mass = -10
        
        // specifying that the sprite is a circle that reacts with other sprites
        // with some physics
        taskBubble.physicsBody = SKPhysicsBody(circleOfRadius: taskBubble.size.width/2)
        taskBubble.physicsBody!.dynamic = true
        taskBubble.userInteractionEnabled = true
        taskBubble.physicsBody!.allowsRotation = false
        taskBubble.physicsBody?.restitution = 0.2
        taskBubble.physicsBody?.angularDamping = 0.8

        
        // name tasks "task" + incrementally increasing number
        taskBubble.name = "task \(i)"
        i++
        
        // add sprite to view & then add string to the sprite
        taskBubble.addChild(taskBubbleLabel)
        self.addChild(taskBubble)

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
        // due to gravity, sprite automatically falls to bottom of screen
    }
    
    func updateTaskBubbleLabel(label: String) {
        taskBubbleLabel = SKLabelNode(fontNamed: "Helvetica Neue")
        taskBubbleLabel.fontColor = UIColor.whiteColor()
        taskBubbleLabel.text = label
        taskBubbleLabel.fontSize = 17
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
 
  