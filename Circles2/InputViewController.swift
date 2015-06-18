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
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var inputBubbleView: UIImageView!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // bubbleView & inputField alpha transition in InputTransition
        inputBubbleView.transform = CGAffineTransformMakeScale(1, 1)
        self.inputField.alpha = 0
        
        // programmatically set color and string of placeholder text
        self.inputField.attributedPlaceholder = NSAttributedString(string:"Enter new todo item",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent((0.6))])

    }
    
    // bug: inputField is not responding as set. Why?
    override func viewDidAppear(animated: Bool) {
        inputField.isFirstResponder()
        inputField.userInteractionEnabled = true
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
    
    // setting alpha of button as a hack to trigger correct transition basde on button alpha
    @IBAction func didTapCancel(sender: UIButton) {
        
        cancelButton.alpha = 0.5
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
 // bug: scale is currently not working as planned
    @IBAction func didPinchInputBubble(sender: UIPinchGestureRecognizer) {
        
        
        if sender.state == UIGestureRecognizerState.Changed {
            
            inputBubbleView.transform = CGAffineTransformMakeScale(sender.scale, sender.scale)
            sender.scale = 3.7
            
        }
        
    }
    
    
    
}
