//
//  HomeViewController.swift
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
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! BubbleScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class HomeViewController: UIViewController {

    
    @IBOutlet var superView: UIView!
    var translate: CGAffineTransform!
    var scale: CGAffineTransform!
    var bubbleScene: BubbleScene!
    @IBOutlet weak var circleView: UIImageView!
    var inputTransition: InputTransition!


    @IBOutlet weak var bubbleView: SKView!
    var selectedImageView: UIImageView!
    
    var size: CGSize!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let scene = BubbleScene.unarchiveFromFile("BubbleScene") as? BubbleScene {
            self.bubbleScene = scene
            let skView = bubbleView as SKView
            println("\(circleView.frame.size)")
            let screenSize  = CGSizeMake(bubbleView.frame.width, bubbleView.frame.height)
            scene.size = screenSize

            skView.showsNodeCount = true

            skView.ignoresSiblingOrder = true
            

            skView.presentScene(scene)

            
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    
    @IBAction func didTapButton(sender: AnyObject) {
        
        
        println("\(circleView.frame.size)")
        performSegueWithIdentifier("inputSegue2", sender: nil)
        
        
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
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! InputViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        inputTransition = InputTransition()
        destinationViewController.transitioningDelegate = inputTransition

        
    }

    
    
    @IBAction func didTap(sender: AnyObject) {
        println("This is covering the other circle")
    }


    
    
    
    
}



