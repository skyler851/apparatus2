//
//  UniversityListViewController.swift
//  Recruitment
//
//  Created by Sean VanPelt on 4/4/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

import UIKit

class UniversityListViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var lblRecruiterName: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblRecruiterName.title = name

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
