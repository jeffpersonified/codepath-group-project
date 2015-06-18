//
//  HomeViewController.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/13/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import SpriteKit

// this is setup for importing the Sprite Scene
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
    
    
    @IBOutlet weak var bubbleView: SKView!
    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!

    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add BubbleScene to HomeViewController
        if let scene = BubbleScene.unarchiveFromFile("BubbleScene") as? BubbleScene {
            self.bubbleScene = scene
            let skView = bubbleView as SKView
            let screenSize  = CGSizeMake(bubbleView.frame.width, bubbleView.frame.height)
            scene.size = screenSize
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
            
            
        }
    }

    // segue to inputViewController when plus is tapped
    @IBAction func didTapButton(sender: AnyObject) {
        
        performSegueWithIdentifier("inputSegue", sender: nil)
        
    }
    
    
    // use custom InputTransition for the segue
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        var destinationViewController = segue.destinationViewController as! InputViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        inputTransition = InputTransition()
        destinationViewController.transitioningDelegate = inputTransition
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    

}



