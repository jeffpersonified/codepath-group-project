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
        

        toViewController.view.alpha = 0

        UIView.animateWithDuration(0, animations: { () -> Void in
            toViewController.view.alpha = 1 
            
        }) { (Bool) -> Void in
        
            
            UIView.animateWithDuration(1.23, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toViewController.view.alpha = 1
                
                var scale = CGAffineTransformMakeScale(3.7, 3.7)
                var translation = CGAffineTransformMakeTranslation(0, -360)
                
                self.inputViewController.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)
                
                
                
                }, completion: nil)
            
        }
            
            
        
        
}

    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
    
   
}
