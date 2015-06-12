//
//  ViewController.swift
//  Exploded circle
//
//  Created by Rebecca Goldman on 6/11/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var longPressGestureRecognizer: UILongPressGestureRecognizer!
    var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    var audioPlayer = AVAudioPlayer()
    var popSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pop", ofType: "wav")!)
    
    @IBOutlet weak var circleExplodedView: UIImageView!
    @IBOutlet weak var circleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: popSound, error: nil)
        audioPlayer.prepareToPlay()
        
        
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongPress:")
        
        longPressGestureRecognizer.minimumPressDuration = 0.2
        
        doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapTwice:")
        
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        
        doubleTapGestureRecognizer.requireGestureRecognizerToFail(longPressGestureRecognizer)
        
        
        self.circleView.addGestureRecognizer(longPressGestureRecognizer)
        self.circleView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        
        circleExplodedView.alpha = 0
        circleView.alpha = 1
        
        self.circleExplodedView.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func didLongPress(sender: UILongPressGestureRecognizer) {
        
        println("I've been long-pressed")
        
        if sender.state == UIGestureRecognizerState.Began {
            
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.circleView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                
                }) { (Bool) -> Void in
                    
                    
                    
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 60, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.circleView.transform = CGAffineTransformMakeScale(1, 1)
                
                }) { (Bool) -> Void in
                    
                    
                    
            }
            
        }
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    func didTapTwice(sender: UITapGestureRecognizer) {
        
        
        println("I've been tapped twice")
   
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 50, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
      
            var initialScale = 1
            
            self.circleView.alpha = 0
            var scaleX = self.convertValue(Float(self.circleView.alpha), r1Min: 1, r1Max: 0, r2Min: Float(initialScale), r2Max: 1.21)
            var scaleY = self.convertValue(
                Float(self.circleView.alpha), r1Min: 0, r1Max: 1, r2Min: 1.21, r2Max: 1.24) // rotation based on translation
            
            self.circleView.transform = CGAffineTransformMakeScale(CGFloat(scaleX), CGFloat(scaleY))
            
            self.audioPlayer.play()
            

            
            }) { (Bool) -> Void in
                
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    println("first animation block")
                    self.circleExplodedView.transform = CGAffineTransformMakeScale(1, 1)
                    
                    self.circleExplodedView.alpha = 1

                    
                    }) { (Bool) -> Void in
                        println("second animation block")
                        
                        
                        UIView.animateWithDuration(0.6, animations: { () -> Void in
                            
                            var translation = CGAffineTransformMakeTranslation(0, 600)
                            self.circleExplodedView.alpha = 0
                            
                            var scale = CGAffineTransformMakeScale(1.4, 1.4)
                            
                            self.circleExplodedView.transform = CGAffineTransformConcat(translation, scale)
                            
                            
                            }) { (Bool) -> Void in
                                println("third animation block")
                                
                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    
                                    
                                    
                                    }) { (Bool) -> Void in
                                }
                        }
                }
        }
    }
    
}