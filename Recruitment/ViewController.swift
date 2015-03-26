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



