//
//  ScoreContoller.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class ScoreController: UIViewController{
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var culture: UISegmentedControl!
    @IBOutlet weak var aptitude: UISegmentedControl!
    @IBOutlet weak var tech: UISegmentedControl!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var decision: UISegmentedControl!
    @IBOutlet weak var star: Score!
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        //check if segue identifier is toThankYouPage
        if identifier == "fromScoreToNewCandidate"{
            return true
        }
        
        if status == "false" {
            return false
        }
        
        if status == "true"{
            performSegueWithIdentifier("fromScoreToNewCandidate", sender: self)
            return true
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
        
        println(techEntered)
        
        if (decisionEntered == 0){ decisionToParse = "No"}
        else {decisionToParse = "Yes"}
        
        var object = PFObject(className: "Candidates")
        object.setObject(cultureEntered , forKey: "culture")
        object.setObject(aptitudeEntered, forKey: "aptitude")
        object.setObject(techEntered, forKey: "tech")
        object.setObject(notesEntered, forKey: "notes")
        object.setObject(decisionToParse, forKey: "decision")
        object.save()
        status = "true"
        
        self.shouldPerformSegueWithIdentifier("fromScoreToNewCandidate", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}