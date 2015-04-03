//
//  ViewController.swift
//  AccordionMenu
//
//  Created by Lataant on 05/03/15.
//  Copyright (c) 2015 Zaeem Solutions. All rights reserved.
//

import UIKit
import ParseUI

class CandidateTableViewController: UIViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!

    var sectionTitleArray : NSMutableArray = NSMutableArray()
    var sectionContentDict : NSMutableDictionary = NSMutableDictionary()
    var arrayForBool : NSMutableArray = NSMutableArray()
    
    var CandidateListArray: NSArray = NSArray()
    var CandidateNameArray: NSArray = NSArray()
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Run Parse function
        retrieveFromParse()
        
        //Variables for the Arrays to display the info
        
        
        //Arrays used for displaying info
        arrayForBool = ["0","0"]
        sectionTitleArray = ["Pool A","Pool B"]
        var tmp1 : NSArray = ["New Zealand","Australia","Bangladesh","Sri Lanka"]
        var string1 = sectionTitleArray .objectAtIndex(0) as? NSString
        [sectionContentDict .setValue(tmp1, forKey:string1! )]
        var tmp2 : NSArray = ["India","South Africa","UAE","Pakistan"]
        string1 = sectionTitleArray .objectAtIndex(1) as? NSString
        [sectionContentDict .setValue(tmp2, forKey:string1! )]
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CandidateCell")
        
        //Menu Button
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    
    func retrieveFromParse() {
        //Get info from the database
        var retrieveAoI = PFQuery(className:"Candidates")
        
        
        
        //Orders AoI in ABC Order
        retrieveAoI.orderByAscending("name")
        
        //Puts info in an Array
        CandidateListArray = retrieveAoI.findObjects()
        
        //CandidateNameArray = CandidateListArray["name"]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            var tps = sectionTitleArray .objectAtIndex(section) as NSString
            var count1 = (sectionContentDict .valueForKey(tps)) as NSArray
            return count1.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(arrayForBool .objectAtIndex(indexPath.section).boolValue == true){
            return 50
        }
        
        return 2;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor(red:84/255.0, green:(118/255.0), blue:(140/255.0), alpha:1.0)
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = sectionTitleArray.objectAtIndex(section) as NSString
        headerString.textColor = UIColor .whiteColor()
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        println("Tapping working")
        println(recognizer.view?.tag)
        
        var indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool .objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayForBool .replaceObjectAtIndex(indexPath.section, withObject: collapsed)
            //reload specific section animated
            var range = NSMakeRange(indexPath.section, 1)
            var sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let CellIdentifier = "CandidateCell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as UITableViewCell
        
        var manyCells : Bool = arrayForBool .objectAtIndex(indexPath.section).boolValue
        
        if (!manyCells) {
            //  cell.textLabel.text = @"click to enlarge";
        }
        else{
            var content = sectionContentDict .valueForKey(sectionTitleArray.objectAtIndex(indexPath.section) as String) as NSArray
            cell.textLabel?.text = content .objectAtIndex(indexPath.row) as? String
            cell.backgroundColor = UIColor .whiteColor()
        }
        
        return cell
    }


}

