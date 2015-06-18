//
//  HomeViewController.swift

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


//  This TableView class typing can be removed once tasks are no longer shown as
//  table cells.

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var superView: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var bubbleView: SKView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    var translate: CGAffineTransform!
    var scale: CGAffineTransform!
    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!
    var selectedImageView: UIImageView!
    var size: CGSize!
    var tasks: [PFObject]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self

        if let scene = BubbleScene.unarchiveFromFile("BubbleScene") as? BubbleScene {
            self.bubbleScene = scene
            let skView = bubbleView as SKView
            let screenSize  = CGSizeMake(bubbleView.frame.width, bubbleView.frame.height)
            scene.size = screenSize
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
        }
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
    
    @IBAction func didTapButton(sender: AnyObject) {
        performSegueWithIdentifier("inputSegue", sender: self)
    }

    // These a table view functions are here for use while tasks are
    // shown as table cells and not circles. They can be removed once
    // tasks have been implemented as circles.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TaskCell") as! TaskCell
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}



