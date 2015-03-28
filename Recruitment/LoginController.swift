//
//  LoginController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/23/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit
var name = ""
var status = ""

class LoginController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        if identifier == "toCandidatePage"{
        if (txtUsername.text.isEmpty) {
            //alert empty password
            let alert = UIAlertView()
            alert.title = "Invalid Password"
            alert.message = "Please enter your 4 digit password"
            alert.addButtonWithTitle("Ok")
            alert.show()
            
            return false
<<<<<<< HEAD
            
=======
        
        
>>>>>>> f3da512e38a4944df6028cd1dee1e11d2c74ce5d
        }
        
        
        if status == "false"{
        //alert that password is wrong
        let alert = UIAlertView()
        alert.title = "Invalid Password"
        alert.message = "Password not found"
        alert.addButtonWithTitle("Ok")
        alert.show()
        
        return false
        }
        
        if status == "true"{
           performSegueWithIdentifier("toCandidatePage", sender: self)
        return true
            }
        }
        return true
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
       var password = txtUsername.text


        var query = PFQuery(className:"Employee")
        query.whereKey("employeeID", equalTo: password )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil || password != "" {
                
                // Fetch matching entry in database
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        status = "true"
                        //println(status)
                        //println(object["Name"])
                        
                    }
                
                if (objects.count == 0) {
                    //wrong password, do not push segue
                    status = "false"
                    println(status)
                    }
                }
                
               
            }else {
                // Log details of the failure
                

                println("Error: \(error) \(error.userInfo!)")
            }
            
         self.shouldPerformSegueWithIdentifier("toCandidatePage", sender: self)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}