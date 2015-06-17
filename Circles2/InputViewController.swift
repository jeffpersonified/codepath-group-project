//
//  InputViewController.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var inputBubbleView: UIImageView!
    
    var image: UIImage!
    var bubbleScene: BubbleScene!
    var cancelTransition: CancelTransition!
    var doneTransition: DoneTransition!

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        inputBubbleView.transform = CGAffineTransformMakeScale(1, 1)

        self.inputField.alpha = 0


        // Do any additional setup after loading the view.
        
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
    


//
    @IBAction func didTapDone(sender: AnyObject) {
        
        println("Tapped Done")
        performSegueWithIdentifier("doneSegue", sender: nil)
        
    }
    
    @IBAction func didTapCancel(sender: AnyObject) {
        
        println("Tapped Cancel")
        performSegueWithIdentifier("cancelSegue", sender: nil)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController as! HomeViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        cancelTransition = CancelTransition()
        destinationViewController.transitioningDelegate = cancelTransition
        
//        
        if segue.identifier == "doneSegue" {
            doneTransition = DoneTransition()
            destinationViewController.transitioningDelegate = doneTransition
       
        }
    
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        var destinationViewController = segue.destinationViewController as! HomeViewController
//        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
//        
//        cancelTransition = CancelTransition()
//        destinationViewController.transitioningDelegate = CancelTransition
//        
//        
//    }
//
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
