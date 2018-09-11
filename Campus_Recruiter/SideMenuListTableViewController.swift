//
//  SideMenuListTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 21/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class SideMenuListTableViewController: UITableViewController {

    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        img.layer.cornerRadius = 85
        img.clipsToBounds = true
        img.layer.borderColor = UIColor.black.cgColor
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       // self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg"))
       // self.tableView.backgroundColor = UIColor().blueClr()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 210
        }
        return 40
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 7{
        AlertContolClass.alertContolWithTwoButtonBlock(alertTitle: "Alert", alertMessage: "Are you sure you want to exit ?", VC: self, blockOne: { (alert) in
           self.performSegue(withIdentifier: "popToRoot", sender: self)
        })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
