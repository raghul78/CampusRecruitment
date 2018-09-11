//
//  WalkInViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 03/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class WalkInViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var sideMenu: UIBarButtonItem!
    var walkInData  = [WalkInDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sideMenu.target = self.revealViewController()
        sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        viewWalkInDetailsFrmSevr()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walkInData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalkIn")as! WalkInTableViewCell
        
        cell.titleLabel.text = walkInData[indexPath.row].job_title
        cell.ExpLabel.text  = walkInData[indexPath.row].totalExperi
        cell.locatLabel.text    =   walkInData[indexPath.row].location
        cell.qualiLabel.text    = walkInData[indexPath.row].start_date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewWalkInDetailsFrmSevr(){
    svProgressShow()
    serviceManager1.parseDataWithPostMethod(serviceApi: "Walkin") { (resData) in
        if resData != nil{
            
            if resData?["status"]as! String == "success"{
                
                let walkInDetails = resData?["Walk-in"]as! NSArray
                for obj in walkInDetails{
                    self.walkInData.append(WalkInDetail.init(dict: obj as! NSDictionary))
                }
                self.tableView.reloadData()
                svProgressDismiss()
            }else{
                svProgressDismiss()
                AlertContolClass.alertContol(alertTitle: "Failed", alertMessage: resData?["status"]as! String, VC: self)
            }
        }
        }
    }
    
    
}


class WalkInDetail{
    
    var job_title       : String!
    var qualification   : String!
    var job_descriptio  : String!
    var prefered_skills : String!
    var job_location    : String!
    var venue           : String!
    var posted_date     : String!
    var experience_from : String!
    var experience_to   : String!
    var start_date      : String!
    var totalExperi     : String!
    var location        : String!
    
    init(dict:NSDictionary) {
        self.job_title          = dict["job_title"]as! String
        self.experience_from    = dict["experience_from"]as! String
        self.experience_to      = dict["experience_to"]as! String!
        self.job_location       = dict["job_location"]as! String!
        self.venue              =   dict["venue"]as! String!
        self.start_date         = dict["start_date"]as! String
        self.qualification      = dict["qualification"]as! String

        
        self.totalExperi        = experience_from + "-" + experience_to + " " + "years"
        self.location           = venue + "," + job_location
    }
    
}
