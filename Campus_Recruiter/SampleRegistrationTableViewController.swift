//
//  SampleRegistrationTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 01/12/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class SampleRegistrationTableViewController: UITableViewController {

    
    @IBOutlet var drop: UIDropDown!
    @IBOutlet var buttonTop: NSLayoutConstraint!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drop.placeholder = "Designation"
        drop.options = ["Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
        drop.didSelect { (str, index) in
            print(str)
        }
        drop.tableWillAppear {
            print("willAppear")
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonTop.constant = 120
            })
        }
        drop.tableWillDisappear {
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonTop.constant = 35
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return UIScreen.main.bounds.height * 0.1
        }
        return UIScreen.main.bounds.height * 0.9
    }
    
    // Function to create Dropdown list
    func showDropdownList(){
        drop.placeholder = "Designation"
        drop.options = ["Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
        drop.didSelect { (str, index) in
            print(str)
        }
        drop.tableWillAppear {
            print("willAppear")
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonTop.constant = 120
            })
        }
        drop.tableWillDisappear {
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonTop.constant = 35
            })
        }
    }
}
