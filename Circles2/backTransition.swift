//
//  backTransition.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class backTransition: BaseTransition {
    
    
    var inputViewController: InputViewController!
    var gameViewController: GameViewController!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        inputViewController = toViewController as! InputViewController
        gameViewController = fromViewController as! GameViewController
        
        inputViewController.view.bounds = gameViewController.view.bounds
        
        
        
        toViewController.view.alpha = 0
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            toViewController.view.alpha = 1
            
            
            }) { (Bool) -> Void in
                
                
                UIView.animateWithDuration(1.02, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    var scale = CGAffineTransformMakeScale(3.7, 3.7)
                    var translation = CGAffineTransformMakeTranslation(0, -360)
                    
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

