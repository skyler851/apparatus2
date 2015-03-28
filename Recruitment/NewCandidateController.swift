//
//  NewCandidateController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/23/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class NewCandidateController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    //submit new candidate info
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var gradDate: UIDatePicker!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    //enter submit button
    @IBAction func submit(sender: AnyObject) {
       
        //get what user typed
        var usrEntered = usernameTextField.text
        var emlEntered = emailTextField.text
        var gradEntered = gradDate.date
        
        //make sure name and email are filled out
        if usrEntered != "" && emlEntered != "" && gradEntered != "" {
            
            //get the call Candidate from parse and enter the data into the columns
            var object = PFObject(className: "Candidates")
            object.setObject(usrEntered , forKey: "name")
            object.setObject(emlEntered, forKey: "email")
            object.setObject(gradEntered, forKey: "gradDate")
            object.save()
            
        } else {
            
            //message if name and email are not filled out
            self.messageLabel.text = "All Fields Required"
        }
        
    }
    //end submit stuff

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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


//get user input
/*var usrEntered = usernameTextField.text
var emlEntered = emailTextField.text

var user = PFUser()
user.username = usrEntered
user.email = emlEntered

func userSignUp(){
    user.signUpInBackgroundWithBlock {
        (succeeded: Bool!, error: NSError!) -> Void in
        if error == nil {
            // Hooray! Let them use the app now.
            self.messageLabel.text = "User Signed Up";
        } else {
            // Show the errorString somewhere and let the user try again.
        }
    }
}

//if name and email are not null
if usrEntered != "" && emlEntered != "" {
    userSignUp()
} else {
    self.messageLabel.text = "All Fields Required"
}
*/