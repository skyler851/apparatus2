//
//  ProfileController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//
import UIKit
var statusResume = ""

class ProfileControllerController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateInfo: UILabel!
    
    //Area of interest
    var TempArray = ["Temp Interest 1",
        "Temp Interest 2",
        "Temp Interest 3",
        "Temp Interest 4"]

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
        return true
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
    
    
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return 4
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    
        return TempArray[row]
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

