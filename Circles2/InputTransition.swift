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
    var gameViewController: GameViewController!

    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        inputViewController = toViewController as! InputViewController
        gameViewController = fromViewController as! GameViewController
        
        inputViewController.view.bounds = gameViewController.view.bounds

     

        toViewController.view.alpha = 0

        UIView.animateWithDuration(0, animations: { () -> Void in
            toViewController.view.alpha = 1

            
        }) { (Bool) -> Void in
        
            
            UIView.animateWithDuration(1.02, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                var scale = CGAffineTransformMakeScale(3.7, 3.7)
                var translation = CGAffineTransformMakeTranslation(0, -360)


                self.inputViewController.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)
                
                
                
                }, completion: { (Bool) -> Void in

            
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.inputViewController.dividerView.alpha = 1
                self.inputViewController.inputField.alpha = 1

                
                
                }, completion: { (Bool) -> Void in
                    
//                    fromViewController.view.removeFromSuperview()
                   self.finish()
                    
            })

            
            })
        }
    
        
    }


    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        println("pressed done")

        inputViewController = fromViewController as! InputViewController
        gameViewController = toViewController as! GameViewController

        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            }) { (finished: Bool) -> Void in
                self.finish()
        }


        
    
    }
}
