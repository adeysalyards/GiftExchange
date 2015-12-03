//
//  PairedWithViewController.swift
//  GiftExchange
//
//  Created by Salyards, Adey on 11/30/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit
import Parse

class PairedWithViewController: UIViewController {
    
    var pairedUser: PFUser!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("I'm in paired with, and I'm matched with \(pairedUser.username!)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
