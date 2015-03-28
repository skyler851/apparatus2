//
//  ViewController.swift
//  Recruitment
//
//  Created by Sean VanPelt on 2/23/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //specifying special things for the app
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*var gameScore = PFObject(className:"Employee")
        gameScore["employeeID"] = 1337
        gameScore["Name"] = "Sean Plott"
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }*/
        /*var query = PFQuery(className:"_User")
        query.whereKey("EmployeeID", equalTo:"0000")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject]{
                    for object in objects {
                        println(object["employeeID"])
                    }
                }
            }
        }*/
        var query = PFQuery(className:"_User")
        PFUser.logInWithUsernameInBackground("0000", password: "1") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("hello")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var IdTextField: UITextField!
    
    @IBAction func IdSubmit(sender: UIButton) { //Button for submiting the ID to login
        
        //insert code for testing their ID against the database to see who it is and log them in. Then go to the 'Admin Menu' page
        
        /*
        if (id is found in database) {
        self.performSegueWithIdentifier("To-AdminMenu", sender: self)
        } else {
        self.messageLabel.text = "ID not found.";
        }
        */
        
        //used for testing. Remove once you get ID check working
        self.performSegueWithIdentifier("To-AdminMenu", sender: self)
        
    }
    
}



