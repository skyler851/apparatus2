//
//  ThankYouController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit
var candName = ""
var jobType = ""
var gradDate = ""
var backPressed = false

class ThankYouController: UIViewController{
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!

    override func didMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            //"Back was pressed"
            backPressed = true
            println(backPressed)
            
        }
    }
func getCandidateName(){
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                // Fetch matching entry in database
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        candName = object["name"] as String
                        jobType = object["jobType"] as String
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MMMM yyyy"
                        var parseDate = object["gradDate"] as NSDate
                        var strDate = dateFormatter.stringFromDate(parseDate)
                        gradDate = strDate + " Grad"

                    }

                }
           
            }else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
            
            
        }
  
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display recruiter name in toolbar
        lblRecruiterName.title = name
        
        //prepare Candidate name for profile page
        getCandidateName()
        
        //menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    //passes the employee name to next contoller

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}