//
//  LoginViewController.swift
//  insta-ground-up
//
//  Created by Malik Browne on 2/23/16.
//  Copyright © 2016 malikbrowne. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: JVFloatLabeledTextField!
    @IBOutlet weak var usernameField: JVFloatLabeledTextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        usernameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        if passwordField.text != nil && usernameField.text != nil {
            PFUser.logInWithUsernameInBackground(self.usernameField.text!, password: self.passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
                
                if let error = error {
                    self.errorLabel.alpha = 0
                    self.errorLabel.textColor = UIColor.redColor()
                    self.errorLabel.text = error.localizedDescription
                    UIView.animateWithDuration(0.3, animations: {
                        self.errorLabel.alpha = 1
                    })
                } else {
                    print("You have logged in.")
                    self.errorLabel.textColor = UIColor(red: 63.0/255.0, green: 153.0/255.0, blue: 76.0/255.0, alpha: 0.9)
                    UIView.animateWithDuration(0.2, animations: {
                        self.errorLabel.text = "\(self.usernameField.text!) has successfully signed in."
                        self.errorLabel.alpha = 1
                    })
                    self.delay(0.4){
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    }
                }
                
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        if usernameField.text?.isEmpty == false && passwordField.text?.isEmpty == false {
            
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("A user was created.")
                    self.passwordField.text = ""
                    self.errorLabel.alpha = 0
                    UIView.animateWithDuration(0.3, animations: {
                        self.errorLabel.textColor = UIColor.greenColor()
                        self.errorLabel.text = "\(newUser.username!) has successfully signed up."
                        self.errorLabel.alpha = 1
                    })
                } else {
                    //                print(error!.localizedDescription)
                    
                    if error?.code == 202 {
                        self.errorLabel.alpha = 0
                        self.errorLabel.text = error?.localizedDescription
                        UIView.animateWithDuration(0.3, animations: {
                            self.errorLabel.alpha = 1
                        })
                    }
                        
                    else if error?.code == 200 {
                        self.errorLabel.alpha = 0
                        self.errorLabel.text = error?.localizedDescription
                        UIView.animateWithDuration(0.3, animations: {
                            self.errorLabel.alpha = 1
                        })
                    }
                        
                    else if error?.code == 201 {
                        self.errorLabel.alpha = 0
                        self.errorLabel.text = error?.localizedDescription
                        UIView.animateWithDuration(0.3, animations: {
                            self.errorLabel.alpha = 1
                        })
                    }
                }
            }
        } else {
            self.errorLabel.alpha = 0
            self.errorLabel.textColor = UIColor.redColor()
            self.errorLabel.text = "Please enter both a username and a password."
            UIView.animateWithDuration(0.3, animations: {
                self.errorLabel.alpha = 1
            })

        }
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
