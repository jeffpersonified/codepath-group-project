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
    
    @IBOutlet weak var dividerView: UIImageView!
    @IBOutlet weak var bubbleView: SKView!
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var tabView: UIVisualEffectView!
    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!
    var longPressRecognizer: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("didLongPressAddTask:"))

        addTaskView.addGestureRecognizer(longPressRecognizer)
        longPressRecognizer.minimumPressDuration = 0.02
        longPressRecognizer.allowableMovement = 5
        addBubbleToHomeView()
    }

    func addBubbleToHomeView() {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    func didLongPressAddTask(sender: UILongPressGestureRecognizer) {
       
        if sender.state == UIGestureRecognizerState.Began {
        
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.addTaskView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                }, completion: nil)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.addTaskView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
            
            performSegueWithIdentifier("newTaskSegue", sender: nil)


        }

        
    }


    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    @IBAction func didPressNewTaskButton(sender: AnyObject) {
        
        performSegueWithIdentifier("newTaskSegue", sender: nil)
    }
}
