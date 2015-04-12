//
//  EmployeeDetailViewController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 4/11/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit



class EmployeeDetailViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmpID: UITextField!
    
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    // Container to store the view table selected object
    var currentObject : PFObject?
    
    
    @IBAction func saveButton(sender: AnyObject) {
        // The save button
        
        
        // Unwrap the current object
        if let object = currentObject? {
            
            object["Name"] = txtName.text
            object["employeeID"] = txtEmpID.text
            
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
        txtName.text = object["Name"] as String
        txtEmpID.text = object["employeeID"] as String
        
    }
    
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}
