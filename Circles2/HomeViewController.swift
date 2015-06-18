//
//  HomeViewController.swift
//  Sutra, Copyright (c) 2015 codepath. All rights reserved.
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
     
    @IBOutlet weak var bubbleView: SKView!
    @IBOutlet weak var circleView: UIImageView!
    
    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTaskScene()
    }
    
    // function to add BubbleScene to HomeViewController
    func setTaskScene() {
        if let scene = BubbleScene.unarchiveFromFile("BubbleScene") as? BubbleScene {
            self.bubbleScene = scene
            let skView = bubbleView as SKView
            let screenSize  = CGSizeMake(bubbleView.frame.width, bubbleView.frame.height)
            
            scene.size = screenSize
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as! InputViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        inputTransition = InputTransition()
        destinationViewController.transitioningDelegate = inputTransition
    }

    @IBAction func didPressNewTaskButton(sender: AnyObject) {
        performSegueWithIdentifier("newTaskSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }


    
  
}
