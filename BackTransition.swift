//
//  BackTransition.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class BackTransition: BaseTransition {
    
    
    
    var inputViewController: InputViewController!
    var homeViewController: HomeViewController!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        inputViewController = fromViewController as! InputViewController
        homeViewController = toViewController as! HomeViewController
        
        inputViewController.view.bounds = homeViewController.view.bounds
        var size = CGSize(width: inputViewController.inputBubbleView.frame.width, height:inputViewController.inputBubbleView.frame.width )
        self.homeViewController.gameScene.addBubble(size: size)
        
        
        toViewController.view.alpha = 0
        
        
                UIView.animateWithDuration(1.02, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    

                    var scale = CGAffineTransformMakeScale(1, 1)
                    var translation = CGAffineTransformMakeTranslation(0, 0)
                    
                    self.inputViewController.inputBubbleView.transform = CGAffineTransformConcat(scale, translation)
                    
                    
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                        
                        UIView.animateWithDuration(1.02
                            , animations: { () -> Void in
                            
                            toViewController.view.alpha = 1
                            
                            
                            }, completion: { (Bool) -> Void in
                                
                                
                                self.finish()
                                
                        })
                        
                        
                })
        }
    }

   

