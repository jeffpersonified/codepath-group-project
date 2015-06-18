//
//  InputViewController.swift
//  Sutra, Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var inputBubbleView: UIImageView!
    
    var image: UIImage!
    var bubbleScene: BubbleScene!
    var inputTransition: InputTransition!
//    var sender: AnyObject!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        inputBubbleView.transform = CGAffineTransformMakeScale(1, 1)

        self.inputField.alpha = 0

        self.inputField.attributedPlaceholder = NSAttributedString(string:"Enter new todo item",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent((0.6))])
        
        image = inputBubbleView.image



    }

    override func viewDidAppear(animated: Bool) {
        inputField.isFirstResponder()
        inputField.userInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    @IBAction func didTapCancel(sender: UIButton) {
        
        println("Tapped Cancel")
        cancelButton.alpha = 0.5
        dismissViewControllerAnimated(true, completion: nil)
        
    }
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var destinationViewController = segue.destinationViewController as! HomeViewController
//        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
//        inputTransition = InputTransition()
//        destinationViewController.transitioningDelegate = inputTransition
//    
//    }
//    
    
    @IBAction func didPinchInputBubble(sender: UIPinchGestureRecognizer) {

    
        if sender.state == UIGestureRecognizerState.Changed {
            
            inputBubbleView.transform = CGAffineTransformMakeScale(sender.scale, sender.scale)
            
            println("scale \(sender.scale)")
        }

}

    
 
}
