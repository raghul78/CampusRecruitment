//
//  JobFairViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 04/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class JobFairViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var jobFairDetail = [JobFairDetail]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var sideMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.target = self.revealViewController()
        sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        JobFairDetailsFrmSevr()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobFairDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobFair")as! JobFairTableViewCell
        
        cell.titleLabel.text = jobFairDetail[indexPath.row].job_title
        cell.ExpLabel.text  = jobFairDetail[indexPath.row].totalExperi
        cell.locateLabel.text    =   jobFairDetail[indexPath.row].job_location
        cell.qualiLabel.text    = jobFairDetail[indexPath.row].start_date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func homeAction(_ sender: Any) {
        print("movee")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func JobFairDetailsFrmSevr(){
        svProgressShow()
        serviceManager1.parseDataWithPostMethod(serviceApi: "jobfair") { (resData) in
            if resData != nil{
                
                if resData?["status"]as! String == "success"{
                    
                    let walkInDetails = resData?["Job Fair"]as! NSArray
                    for obj in walkInDetails{
                        self.jobFairDetail.append(JobFairDetail.init(dict: obj as! NSDictionary))
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
class JobFairDetail{
    
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

