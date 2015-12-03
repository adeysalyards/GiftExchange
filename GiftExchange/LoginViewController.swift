//
//  LoginViewController.swift
//  GiftExchange
//
//  Created by Salyards, Adey on 11/30/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var pairedUser: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressSignUpButton(sender: AnyObject) {
        let user = PFUser()
        
        user.username = nameField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock { (status: Bool, error: NSError?) -> Void in
            if error == nil {
                user.addUniqueObject(user.username!, forKey: "no_munch_list")
                user.saveInBackgroundWithBlock({ (status: Bool, error: NSError?) -> Void in
                    self.login()
                })
            } else {
                print("Error: \(error)")
            }

        }
        
    }
    
    @IBAction func didTapLoginButton(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(nameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                user!.addUniqueObject(user!.username!, forKey: "no_munch_list")
                user!.saveInBackgroundWithBlock({ (status: Bool, error: NSError?) -> Void in
                    self.login()
                })
            } else {
                print("Error: \(error)")
            }
        }
        
    }
    
    func login() {
        PFUser.query()!.countObjectsInBackgroundWithBlock { (count: Int32, error: NSError?) -> Void in
            let currentUser = PFUser.currentUser()!
            let noMunchList = currentUser["no_munch_list"] as! [AnyObject]
            let query = PFUser.query()!
            query.limit = 1
            query.skip = Int(arc4random_uniform(UInt32(count))) - noMunchList.count
            query.whereKey("username", notContainedIn: noMunchList)
            query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error:NSError?) -> Void in
                self.pairedUser = object as! PFUser
                print("found match: \(self.pairedUser.username!)")
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            })
        }
    }

    @IBAction func onButton(sender: AnyObject) {
        login()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let pairedWithViewController = segue.destinationViewController as! PairedWithViewController
        
        pairedWithViewController.pairedUser = pairedUser
    }

}
