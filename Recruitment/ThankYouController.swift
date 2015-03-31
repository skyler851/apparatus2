//
//  ThankYouController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class ThankYouController: UIViewController{
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display recruiter name in toolbar
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
}