//
//  ProfileController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//
import UIKit
<<<<<<< HEAD
import ParseUI
=======
var statusResume = ""
var areaEntered = ""
var statusProfile = ""
>>>>>>> master

class ProfileControllerController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateInfo: UILabel!
    
    //Area of interest
    var TempArray = ["AREA OF INTEREST:",
        "Genreral",
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

    var AoIArray: NSArray = NSArray()
    //end area of interest
    
    //go to next pageif segue is fromScoreToBewCandidate
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        //check segue identifier
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
            if statusProfile == "false" {
                
                //alert that email already exists
                let alert = UIAlertView()
                alert.title = "Resume Does Not Exist"
                alert.message = "Please take a picture of the resume and save it to the database"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                return false
            }
            if statusProfile == "true"{
                performSegueWithIdentifier("toScorePage", sender: self)
                return true
            }
        }
        return true
    }

    //View Resume Button was pressed
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
                    object.saveInBackgroundWithBlock {
                        (success: Bool, error: NSError!) -> Void in
                        if (success) {
                            // The object has been saved.
                            
                        } else {
                            // There was a problem, check error.description
                        }
                    }
                    statusProfile = "true"
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
                        object.saveInBackgroundWithBlock {
                            (success: Bool, error: NSError!) -> Void in
                            if (success) {
                                // The object has been saved.
                            } else {
                                // There was a problem, check error.description
                            }
                        }
                        statusProfile = "true"
                        
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
    
    //enter submit button
    @IBAction func submit(sender: UIBarButtonItem) {
        
        
        if (backPressed == false){
            createNewPFObject()
        }
        
        
        if (backPressed == true){
            //if this page is accessed again via the back button from ThankYou page, the user presumably wants to make changes that will overwrite his/her submitted entry. The following code ensures that a new object is NOT created IF and ONLY IF the back button is pressed from the ThankYou page
            
            updatePFObject()
            
            
        }
        
        
    }
    //end submit stuff

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //display recruiter name in toolbar
        lblRecruiterName.title = name
        
        //display candidate name in heading
        candidateName.text = candName
        
        //display candidate name in heading
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
        AoIArray = retrieveAoI.findObjects()
    
    
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return 15
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    
        return TempArray[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        areaEntered = TempArray[row]
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

