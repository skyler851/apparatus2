//
//  EventsDetailViewController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 4/13/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUniversity: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    // Container to store the view table selected object
    
    var currentObject : PFObject?
    
    
    @IBAction func saveButton(sender: AnyObject) {
        // The save button
        
        
        // Unwrap the current object
        if let object = currentObject? {
            
            object["eventName"] = txtName.text
            object["university"] = txtUniversity.text
            
            var strDate = txtDate.text
            var date : NSDate?
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
             date = dateFormatter.dateFromString(strDate)
            
            object["date"] = date

            
            // Save the data back to the server in a background task
            object.saveEventually(nil)
            
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblRecruiterName.title = name
        // Unwrap the current object object
        if let object = currentObject? {
            txtName.text = object["eventName"] as String
            txtUniversity.text = object["university"] as String
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var parseDate = object["date"] as NSDate
            var strDate = dateFormatter.stringFromDate(parseDate)
            
            
            txtDate.text = strDate
        }
        
        //menu
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
