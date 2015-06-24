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
        
//        toViewController.view.alpha = 0
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
//            toViewController.view.alpha = 1
            
            }) { (Bool) -> Void in
                
                // transform the input button into the input bubble
                
                UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    var scale = CGAffineTransformMakeScale(3.7, 3.7)
                    var translation = CGAffineTransformMakeTranslation(0, -390)
                    
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
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // cancel transition
        if inputViewController.cancelButton.alpha == 0.5 {
            
            
            UIView.animateWithDuration(0.54, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                var scale = CGAffineTransformMakeScale(1, 1)
                var translation = CGAffineTransformMakeTranslation(0, 0)
                
                self.inputViewController.cancelButton.alpha = 0
                self.inputViewController.doneButton.alpha = 0
                self.inputViewController.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)

                
                
                
                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        
                        containerView.alpha = 0

                        
                        }, completion: { (Bool) -> Void in
                            
                            self.finish()
                            
                    })
                    
            })
            
            
            // done transition
        } else if inputViewController.doneButton.alpha == 0.5 {
            
            self.homeViewController.addTaskView.transform = CGAffineTransformMakeTranslation(0, 80)
            self.homeViewController.tabView.transform = CGAffineTransformMakeTranslation(0, 80)
            self.homeViewController.dividerView.transform = CGAffineTransformMakeTranslation(0, 80)

            // size, string & location are passed to the addBubble() function
            // to display the sprite with the proper string and dimensions in the Scene
            var size = CGSize(width: inputViewController.inputBubbleView.frame.width, height:inputViewController.inputBubbleView.frame.width)
            var string = inputViewController.inputField.text
            var location = inputViewController.inputBubbleView.center 
            self.homeViewController.bubbleScene.addTaskBubble(size: size, string: string, location: location)

            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.inputViewController.cancelButton.alpha = 0
                self.inputViewController.doneButton.alpha = 0
                containerView.alpha = 0


                }, completion: { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.24, delay: 0.4, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        
                        self.homeViewController.dividerView.transform = CGAffineTransformMakeTranslation(0, 0)
                        self.homeViewController.addTaskView.transform = CGAffineTransformMakeTranslation(0, 0)
                        self.homeViewController.tabView.transform = CGAffineTransformMakeTranslation(0, 0)
                        
                    }, completion: { (Bool) -> Void in
                        
                        self.finish()

                    })
                    
                    
                    
            })
        }
    }
    
}
