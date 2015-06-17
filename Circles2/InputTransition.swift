//
//  InputTransition.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class InputTransition: BaseTransition {
    
    
    var inputViewController: InputViewController!
    var homeViewController: HomeViewController!

    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        inputViewController = toViewController as! InputViewController
        homeViewController = fromViewController as! HomeViewController
        
        inputViewController.view.bounds = homeViewController.view.bounds

     

        toViewController.view.alpha = 0

        UIView.animateWithDuration(0.1, animations: { () -> Void in
            toViewController.view.alpha = 1

            
        }) { (Bool) -> Void in
        
            
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                var scale = CGAffineTransformMakeScale(3.7, 3.7)
                var translation = CGAffineTransformMakeTranslation(0, -380)

                self.inputViewController.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)
                
                
                }, completion: { (Bool) -> Void in

            
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.inputViewController.inputField.alpha = 1

                
                }, completion: { (Bool) -> Void in
                    

                   self.finish()
                    
            })

            
            })
        }
    
        
    }


}
