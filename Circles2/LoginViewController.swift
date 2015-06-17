//
//  LoginViewController.swift
//  Circles2
//
//  Created by Rebecca Goldman on 6/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressSignUpButton(sender: AnyObject) {
        signUpUser()
    }
    
    @IBAction func didPressLoginButton(sender: AnyObject) {
        logInUser()
    }

    func signUpUser() {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                println(errorString)
                println("Failed to Sign In")
            } else {
                self.performSegueWithIdentifier("OpenSesame", sender: nil)
            }
        }
    }
    
    func logInUser() {
        let username = usernameField.text
        let password = passwordField.text
        
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("OpenSesame", sender: nil)
            } else {
                println("Failed to Sign Up")
            }
        }
    }
}
