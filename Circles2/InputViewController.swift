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
    
    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputBubbleView.transform = CGAffineTransformMakeScale(1, 1)

        self.inputField.alpha = 0

        // Do any additional setup after loading the view.
        
        self.inputField.isFirstResponder()
        self.inputField.attributedPlaceholder = NSAttributedString(string:"Enter new todo item",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent((0.6))])
        


    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
        
            var scale = CGAffineTransformMakeScale(3.7, 3.7)
            var translation = CGAffineTransformMakeTranslation(0, -360)
            
            self.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)
            
            
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.inputField.alpha = 1
                    
                    
                }, completion: { (Bool) -> Void in
                    
                    self.inputField.isFirstResponder()

                })

        }
        
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
