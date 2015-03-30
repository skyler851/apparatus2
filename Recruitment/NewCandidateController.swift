import UIKit

var candidateEmail = ""

class NewCandidateController: UIViewController{

        @IBOutlet weak var menuButton:UIBarButtonItem!
        
        //submit new candidate info
        @IBOutlet weak var usernameTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var gradDate: UIDatePicker!
        @IBOutlet weak var jobType: UISegmentedControl!
        
        //perform segue to go to thank you page
        override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
            
            //check if segue identifier is toThankYouPage
            if identifier == "toThankYouPage"{
                
                if (emailTextField.text.isEmpty) {
                    //alert empty email
                    let alert = UIAlertView()
                    alert.title = "Invalid Email"
                    alert.message = "Please enter your email address"
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                    return false
                }
                
                if status == "false"{
                    //alert that email already exists
                    let alert = UIAlertView()
                    alert.title = "Email Already Exists"
                    alert.message = "Please let the recruiter know that your email is already in our system"
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                    return false
                }
                
                if status == "true"{
                    performSegueWithIdentifier("toThankYouPage", sender: self)
                    return true
                }
            }
            return true
        }
        
        
        //enter submit button
        @IBAction func submit(sender: UIBarButtonItem) {
            
            //get what user typed
            var usrEntered = usernameTextField.text
            var emlEntered = emailTextField.text
            var gradEntered = gradDate.date
            var jobEntered = jobType.selectedSegmentIndex
            var jobToParse = ""
            
            if (jobEntered == 0){ jobToParse = "Full-Time May"}
            else if (jobEntered == 1){jobToParse = "Full-Time Dec"}
            else {jobToParse = "Internship"}
            
            var query = PFQuery(className:"Candidates")
            query.whereKey("email", equalTo: emlEntered )
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                
                //make sure name and email are filled out
                if usrEntered != "" && emlEntered != "" && gradEntered != "" || error == nil {
                    
                    if (objects.count == 0) {
                        //get the call Candidate from parse and enter the data into the columns
                        var object = PFObject(className: "Candidates")
                        object.setObject(usrEntered , forKey: "name")
                        object.setObject(emlEntered, forKey: "email")
                        object.setObject(gradEntered, forKey: "gradDate")
                        object.setObject(jobToParse, forKey: "jobType")
                        object.saveInBackgroundWithBlock {
                            (success: Bool, error: NSError!) -> Void in
                            if (success) {
                                // The object has been saved.
                            } else {
                                // There was a problem, check error.description
                            }
                        }
                        status = "true"
                        
                        candidateEmail = emlEntered
                    }
                    
                    if (objects.count != 0) {
                        //email already exists, do not push segue
                        status = "false"
                    }
                }
                    
                else {
                    println("Error: \(error) \(error.userInfo!)")
                }
                self.shouldPerformSegueWithIdentifier("toThankYouPage", sender: self)
            }
        }
        //end submit stuff

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
