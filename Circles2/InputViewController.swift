//
//  InputViewController.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!
    
    @IBOutlet var inputBackgroundView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var inputBubbleView: UIImageView!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting initial scale & alpha values to transition in InputTransition
        
        inputBackgroundView.backgroundColor = UIColor(red: 250/255, green: 212/255, blue: 141/255, alpha: 1)
        inputBubbleView.transform = CGAffineTransformMakeScale(1, 1)
        self.inputField.alpha = 0
        
        // programmatically set color and string of placeholder text
        self.inputField.attributedPlaceholder = NSAttributedString(string:"New task",
            attributes:[NSForegroundColorAttributeName: UIColor(red: 186/255, green: 146/255, blue: 79/255, alpha: 0.6)])
    }
    
    override func viewDidAppear(animated: Bool) {
        inputField.isFirstResponder()
        // bug: inputField is not responding as first responder. Why?
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // sets up Parse tracking when task is saved
    @IBAction func didTapDone(sender: AnyObject) {
        let task = PFObject(className: "Task")
        let user = PFUser.currentUser()!
        task["content"] = inputField.text
        task["author"] = user
        task.ACL = PFACL(user: user)
        
        task.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.doneButton.alpha = 0.5
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                println("Failed to save")
            }
        }
    }
    
    // setting alpha of button as a hack to trigger correct transition based on button alpha
    @IBAction func didTapCancel(sender: UIButton) {
        cancelButton.alpha = 0.5
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func didScaleBubble(sender: UIPinchGestureRecognizer) {
        self.inputBubbleView.transform = CGAffineTransformScale(self.inputBubbleView.transform, sender.scale, sender.scale)
        sender.scale = 1
    
    }
 
    
}

    