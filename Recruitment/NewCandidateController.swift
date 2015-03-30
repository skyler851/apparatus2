import UIKit
import Parse

class NewCandidateController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var AreaOfInterest: UIPickerView!
    
    var TempArray = ["Temp Interest 1",
        "Temp Interest 2",
        "Temp Interest 3",
        "Temp Interest 4"]
    
    var AoIArray = []

    //submit new candidate info
    var name = ""
    var status = ""
    
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
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
            if status == "false"{
                //alert that email already exists
                let alert = UIAlertView()
                alert.title = "Email Already Exists"
                alert.message = "Please let the recruiter know that your email is already in our system"
                alert.addButtonWithTitle("Ok")
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
                    object.save()
                    self.status = "true"
                }
                
                if (objects.count != 0) {
                    //email already exists, do not push segue
               self.status = "false"
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
