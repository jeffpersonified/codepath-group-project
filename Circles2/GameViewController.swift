//
//  GameViewController.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    
    @IBOutlet var superView: UIView!
    var translate: CGAffineTransform!
    var scale: CGAffineTransform!
    var gameScene: GameScene!
    @IBOutlet weak var circleView: UIImageView!

    @IBOutlet weak var bubbleView: SKView!
    
    var size: CGSize!
    
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            self.gameScene = scene
            let skView = bubbleView as! SKView
            println("\(circleView.frame.size)")
        let screenSize  = CGSizeMake(bubbleView.frame.width, bubbleView.frame.height)
        scene.size = screenSize

            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */

//            scene.scaleMode = .AspectFit
            
//            scene.imageToPass = createdImage

            
            skView.presentScene(scene)

            
            doneButton.alpha = 0
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    
    @IBAction func didTapButton(sender: AnyObject) {
        
        doneButton.alpha = 1
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            self.bubbleView.alpha = 0
            self.translate = CGAffineTransformMakeTranslation(0, -110)
            self.scale = CGAffineTransformMakeScale(2.6, 2.6)
            self.circleView.transform = CGAffineTransformConcat(self.translate, self.scale)

        }, completion: nil)
        
        
        println("\(circleView.frame.size)")
        
        
        
    }
    
    
    
    
    @IBAction func didTapDone(sender: AnyObject) {
//        var width = CGFloat(arc4random_uniform(100) + 20)
        var size = CGSize(width: circleView.frame.width, height: circleView.frame.width)
        
//        var string =
        gameScene.addBubble(size: size) 
        println("\(circleView.frame.size)")

        
        
    }
    
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}



