//
//  ScoreContoller.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit
import ParseUI


class ScoreController: UIViewController{
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateInfo: UILabel!
    
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    @IBOutlet weak var culture: UISegmentedControl!
    @IBOutlet weak var aptitude: UISegmentedControl!
    @IBOutlet weak var tech: UISegmentedControl!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var decision: UISegmentedControl!
    @IBOutlet weak var star: Score!
    
    //go to next pageif segue is fromScoreToBewCandidate
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        //check if segue identifier is fromScoreToNewCandidate
        if identifier == "fromScoreToNewCandidate"{
            if status == "false" { return false }
            if status == "true"{
                performSegueWithIdentifier("fromScoreToNewCandidate", sender: self)
                return true
            }
        }
        if identifier == "toResume"{
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
                performSegueWithIdentifier("toResume", sender: self)
                return true
            }
        }
        return true
    }
    
    //enter submit button
    @IBAction func submit(sender: UIBarButtonItem) {

        //get what user typed
        var cultureEntered = culture.selectedSegmentIndex + 1
        var aptitudeEntered = aptitude.selectedSegmentIndex + 1
        var techEntered = tech.selectedSegmentIndex + 1
        var notesEntered = notes.text
        var decisionEntered = decision.selectedSegmentIndex
        var decisionToParse = ""
        var favoriteToParse = ""
        
        if (decisionEntered == 0){ decisionToParse = "No"}
        else {decisionToParse = "Yes"}
        
        if (favorite == "true"){ favoriteToParse = "Yes"}
        else {decisionToParse = "No"}
        
        println(candidateEmail)
        
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            for object in objects {
                
                object.setObject(cultureEntered , forKey: "culture")
                object.setObject(aptitudeEntered, forKey: "aptitude")
                object.setObject(techEntered, forKey: "tech")
                object.setObject(favoriteToParse, forKey: "favorite")
                object.setObject(notesEntered, forKey: "notes")
                object.setObject(decisionToParse, forKey: "decision")
                object.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        // The object has been saved.
                    } else {
                        // There was a problem, check error.description
                    }
                }
                status = "true"
            }
            
            if (objects.count == 0) {
                //wrong password, do not push segue
                status = "false"
                println(status)
            }
            self.shouldPerformSegueWithIdentifier("fromScoreToNewCandidate", sender: self)
        }

    }
    
    //view resume button
    @IBAction func resume(sender: UIButton) {
        
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            for object in objects {
                if (object .objectForKey("resume") != nil){
                    statusResume = "true"
                    println(statusResume)
                }
                else{
                    statusResume = "false"
                    println(statusResume)
                }
                
            }
            self.shouldPerformSegueWithIdentifier("toResume", sender: self)
        }
        

        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display Recruiter name
        lblRecruiterName.title = name
        
        //display candidate name in heading
        candidateName.text = candName
        
        //display candidate name in heading
        candidateInfo.text = jobType + " | " + gradDate
        
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