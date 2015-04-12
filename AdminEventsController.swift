//
//  AdminEventsController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 4/8/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import Foundation
import UIKit


class AdminEventsController: UIViewController{
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display recruiter name in toolbar
        lblRecruiterName.title = name
        
        //menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    //passes the employee name to next contoller
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}