//
//  ResumeController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/30/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit
import ParseUI

class ResumeController: UIViewController {
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var resumeView: PFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get class in parse where email = candidate email entered on New Candidate page
        var query = PFQuery(className:"Candidates")
        query.whereKey("email", equalTo: candidateEmail )
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            for object in objects {
                
                let resumeParse = object["resume"] as PFFile
                resumeParse.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        self.resumeView.image = UIImage(data: imageData)
                        
                    }
                }
                
            }
        }

    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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

