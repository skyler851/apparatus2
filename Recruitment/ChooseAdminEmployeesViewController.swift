//
//  ChooseAdminEmployeesViewController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 4/11/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit
import Foundation

class ChooseAdminEmployeesViewController: PFQueryTableViewController {
    
    
    // Initialise the PFQueryTable tableview
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Employee"
        self.textKey = "Name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as EmployeeDetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = objects[row] as? PFObject
        }
    }
    
//    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
//        return true
//    }
//    
//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                let row = Int(indexPath.row)
//
//            objects.delete(row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//        }
//    }
    
    
    
//    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            
//           
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//
//            
//            
////            // Remove the row from data model
//                var query = PFQuery(className:"Candidates")
//                query.whereKey("Name", equalTo:  )
//                query.findObjectsInBackgroundWithBlock {
//                    (objects: [AnyObject]!, error: NSError!) -> Void in
//                    
//                    //make sure name and email are filled out
//                    if error == nil {
//                        
//                        if let objects = objects as? [PFObject] {
//                            for object in objects {
//                                
//                                object.delete()
//                                
//                            }
//                        }
//                        else {
//                            println("Error: \(error) \(error.userInfo!)")
//                        }
//                        
//                    }
//                    
//                }
//            }
//            }
//        }
//    }
//    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: "Employee")
        query.orderByAscending("Name")
        return query
    }
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        cell?.textLabel?.text = object["Name"] as String!
        
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
