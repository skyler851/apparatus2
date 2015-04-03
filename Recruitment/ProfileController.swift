//
//  ProfileController.swift
//  Recruitment
//
//  Created by Stephanie Kyler on 3/29/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//
import UIKit
import ParseUI

class ProfileControllerController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var menuButton:UIBarButtonItem!

    //Area of interest
    var TempArray = ["Temp Interest 1",
        "Temp Interest 2",
        "Temp Interest 3",
        "Temp Interest 4"]

    var AoIArray: NSArray = NSArray()
    //end area of interest

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
        AoIArray = retrieveAoI.findObjects()
    
    
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

