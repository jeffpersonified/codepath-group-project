//
//  DoneTransition.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class DoneTransition: BaseTransition {
    
    
    var inputViewController: InputViewController!
    var homeViewController: HomeViewController!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        inputViewController = fromViewController as! InputViewController
        homeViewController = toViewController as! HomeViewController
        
        inputViewController.view.bounds = homeViewController.view.bounds
        var size = CGSize(width: inputViewController.inputBubbleView.frame.width, height:inputViewController.inputBubbleView.frame.width)
        var string = inputViewController.inputField.text
        var location = inputViewController.inputBubbleView.center
        self.homeViewController.bubbleScene.addBubble(size: size, string: string, location: location)
        
        
        toViewController.view.alpha = 0
        
        
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            toViewController.view.alpha = 1

            self.inputViewController.inputBubbleView.alpha = 0
            self.homeViewController.bubbleScene.alpha = 1

            }, completion: { (Bool) -> Void in
                
                self.finish()

        })
    }
   
}
