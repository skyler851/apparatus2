//
//  ChooseEventViewController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 4/13/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class ChooseEventViewController: PFQueryTableViewController {

    // Initialise the PFQueryTable tableview
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "EventsTable"
        self.textKey = "eventName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as EventsDetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = objects[row] as? PFObject
        }
    }
    
    @IBAction func addButton(sender: AnyObject) {
        
        let passwordPrompt = UIAlertController(title: "Enter New Employee Information", message: "Please enter the employee's full name and a 4 digit password.", preferredStyle: UIAlertControllerStyle.Alert)
        
        passwordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        passwordPrompt.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: nil))
        
        
        passwordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            
            textField.layer.cornerRadius = 0.2
            
            textField.placeholder = "Name"
            textField.secureTextEntry = true
            
        })
        passwordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        })
        
        presentViewController(passwordPrompt, animated: true, completion: nil)
        }

    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
            return true
        }
    
    
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    let row = Int(indexPath.row)
    
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            }
        }
    
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: "EventsTable")
        query.orderByAscending("eventName")
        return query
    }
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "EventCell")
        }
        
        // Extract values from the PFObject to display in the table cell
        cell?.textLabel?.text = object["eventName"] as String!
        
        return cell
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
