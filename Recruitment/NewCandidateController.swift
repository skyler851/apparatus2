import UIKit

var candidateEmail = ""

class NewCandidateController: UIViewController{
    
    var toPass:String!
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    //submit new candidate info
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var gradDate: UIDatePicker!
    @IBOutlet weak var jobType: UISegmentedControl!
    
    //initialize
    var usrEntered = ""
    var emlEntered = ""
    var gradEntered = NSDate()
    var jobEntered = 0
    var jobToParse = ""
    
    //perform segue to go to thank you page
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        //check if segue identifier is toThankYouPage
        if identifier == "toThankYouPage"{
            
            if (usernameTextField.text.isEmpty) {
                //alert empty email
                let alert = UIAlertView()
                alert.title = "Invalid Entry"
                alert.message = "Please enter your full name"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                return false
            }
            
            if (emailTextField.text.isEmpty) {
                //alert empty email
                let alert = UIAlertView()
                alert.title = "Invalid Entry"
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
    
    func createNewPFObject(){
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
    func updatePFObject(){
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
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //get the call Candidate from parse and update the data in the columns
                        object["name"] = usrEntered
                        object["email"] = emlEntered
                        object["gradDate"] = gradEntered
                        object["jobType"] = jobToParse
                        
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
                        
                        if (objects.count == 0) {
                            object.delete()
                            self.createNewPFObject()
                        }
                    }
                    
                }
                
                else {
                    println("Error: \(error) \(error.userInfo!)")
                }
                
                self.shouldPerformSegueWithIdentifier("toThankYouPage", sender: self)
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
            
            //display Recruiter name
            lblRecruiterName.title = name
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
