//
//  CampusRecruitmentViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 03/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class CampusRecruitmentViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionViww: UICollectionView!
    @IBOutlet var sideMenu: UIBarButtonItem!
    var campusRecruitment = [CampusRecruitment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenu.target = self.revealViewController()
        sideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        collectionViww.i
        viewWalkInDetailsFrmSevr()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campusRecruitment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Campus", for: indexPath)as! CampusRecruitCollectionViewCell
        
        cell.comNameLabel.text = campusRecruitment[indexPath.row].job_title
        cell.locationLabel.text = campusRecruitment[indexPath.row].location
        cell.skillLabel.text = campusRecruitment[indexPath.row].prefered_skills
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: view.bounds.width - 5, height:layout.itemSize.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewWalkInDetailsFrmSevr(){
        svProgressShow()
        serviceManager1.parseDataWithPostMethod(serviceApi: "campus") { (resData) in
            if resData != nil{
                
                if resData?["status"]as! String == "success"{
                    
                    let campusDetails = resData?["Campus Recruitment"]as! NSArray
                    for obj in campusDetails{
                        self.campusRecruitment.append(CampusRecruitment.init(dict: obj as! NSDictionary))
                    }
                    self.collectionViww.reloadData()
                    svProgressDismiss()
                }else{
                    svProgressDismiss()
                    AlertContolClass.alertContol(alertTitle: "Failed", alertMessage: resData?["status"]as! String, VC: self)
                }
            }
        }
    }
    
}

class CampusRecruitment{
    
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
        self.job_title          = dict["job_code"]as! String
        self.experience_from    = dict["experience_from"]as! String
        self.experience_to      = dict["experience_to"]as! String!
        self.job_location       = dict["job_location"]as! String!
        self.venue              =   dict["venue"]as! String!
        self.start_date         = dict["start_date"]as! String
        prefered_skills     = dict["prefered_skills"]as! String

        
        self.totalExperi        = experience_from + "-" + experience_to + " " + "years"
        self.location           = venue + "," + job_location
    }
    
}
