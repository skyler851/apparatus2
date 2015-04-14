//
//  ProfileController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//
import UIKit
import Foundation
import ParseUI

var statusResume = ""
var statusSkills = ""
var areaEntered = ""
var statusProfile = ""




class ProfileControllerController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateInfo: UILabel!
    
   
    
    //Area of interest
    var TempArray = ["AREA OF INTEREST:",
        "General",
        "Business Intelligence",
        "Client Services",
        "Cloud Delivery",
        "Database Administration",
        "Development Operations",
        "Enterprise Application Delivery",
        "Identity Management",
        "Information Security",
        "Infrastructure",
        "Kore Platform Development",
        "Project Management",
        "Saas Administration",
        "Sales",
        "Solutions Development"]
    var AoIArray = []
    //end area of interest
    
    //go to next pageif segue is fromScoreToBewCandidate
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        //check if segue identifier is fromScoreToNewCandidate
        if identifier == nil{
            println("nil")
            return true
        }
        
        if identifier == "profileToResume"{
            if statusResume == "false" {
                
                //alert that email already exists
                let alert = UIAlertView()
                alert.title = "Resume Does Not Exist"
                alert.message = "Please take a picture of the resume and save it to the database"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                return false
            }
            if statusResume == "true"{
                performSegueWithIdentifier("profileToResume", sender: self)
                return true
            }
        }
        if identifier == "toScorePage"{
            if statusSkills == "false" {
                //alert that email already exists
                let alert = UIAlertView()
                alert.title = "Resume Does Not Exist"
                alert.message = "Please take a picture of the resume and save it to the database"
                alert.addButtonWithTitle("OK")
                alert.show()
                return false
            }
            if statusSkills == "true"{
                performSegueWithIdentifier("toScorePage", sender: self)
                return true
            }
        }
        return true
    }
    
    //Enter Area of Interest
    func createNewPFObject(){
        
        //get candidate where email = candidate email entered
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            //find area column in parse
            for object in objects {
                object.setObject(areaEntered , forKey: "area")
                object.setObject(SkillResult , forKey: "skills")
                object.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        // The object has been saved.
                        
                    } else {
                        // There was a problem, check error.description
                    }
                }
                statusSkills = "true"
            }
            self.shouldPerformSegueWithIdentifier("toScorePage", sender: self)
        }
    }
    
    //Update Area of Interest
    func updatePFObject(){
        
        //get candidate where email = candidate email entered
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            //make sure name and email are filled out
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        //get the call area from parse and update the data in the columns
                        object["area"] = areaEntered
                        object["skills"] = SkillResult
                        object.saveInBackgroundWithBlock {
                            (success: Bool, error: NSError!) -> Void in
                            if (success) {
                                // The object has been saved.
                            } else {
                                // There was a problem, check error.description
                            }
                        }
                        statusSkills = "true"
                        
                        //If there is nothing in the area column in Parse, add the newly entered one
                        if (objects.count == 0) {
                            object.delete()
                            self.createNewPFObject()
                        }
                    }
                }
                else {
                    println("Error: \(error) \(error.userInfo!)")
                }
                
                self.shouldPerformSegueWithIdentifier("toScorePage", sender: self)
            }
        }
        
    }
    
    
    //enter skills into Parse
    @IBAction func submit(sender: AnyObject) {
        
        /*var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        
        for object in objects {
        object.setObject(SkillResult , forKey: "skills")
        object.saveInBackgroundWithBlock {
        (success: Bool, error: NSError!) -> Void in
        if (success) {
        // The object has been saved.
        } else {
        // There was a problem, check error.description
        }
        }
        statusSkills = "true"
        }
        if (objects.count == 0) {
        //already exists, do not push segue
        statusSkills = "false"
        }
        self.shouldPerformSegueWithIdentifier("toScorePage", sender: self)
        }*/
        
        if (backPressed == false){
            createNewPFObject()
        }
        
        
        if (backPressed == true){
            //if this page is accessed again via the back button from ThankYou page, the user presumably wants to make changes that will overwrite his/her submitted entry. The following code ensures that a new object is NOT created IF and ONLY IF the back button is pressed from the ThankYou page
            
            updatePFObject()
            
        }
        
    }
    
    
    @IBAction func viewResume(sender: UIButton) {
        
        //find candidates class in Parse where column email = candidate's email
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            for object in objects {
                //if resume column in Parse is not nil
                if (object .objectForKey("resume") != nil){
                    statusResume = "true"
                    println(statusResume)
                }
                else{
                    statusResume = "false"
                    println(statusResume)
                }
            }
            self.shouldPerformSegueWithIdentifier("profileToResume", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil  {
                
                // Fetch matching entry in database
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        candName = object["name"] as String
                        
                    }
                    
                    if (objects.count == 0) {
                        println("no objects")
                    }
                }
                
                
            }else {
                // Log details of the failure
                
                
                println("Error: \(error) \(error.userInfo!)")
            }
            
            
        
    }

        //display recruiter name in toolbar
        lblRecruiterName.title = name
        //var x = tempVar
        
        candidateName.text = candName
        
        
        
        //display candidate info in heading
        candidateInfo.text = jobType + " | " + gradDate
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
    
    func retrieveFromParse() {
        //Get info from the database
        var retrieveAoI = PFQuery(className:"SkillsTable")
        
        //Orders AoI in ABC Order
        retrieveAoI.orderByAscending("AoI")
        
        //Puts info in an Array
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 16
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return TempArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        areaEntered = TempArray[row]
    }
    
    
    
}

