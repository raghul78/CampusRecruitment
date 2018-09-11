//
//  HomePageTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 21/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit
import SDWebImage


class HomePageTableViewController: UITableViewController {
    
    var getCollName         :   String!
    var collgeId            :   String!
    var floatingButton     : UIButton!
    
    @IBOutlet var sideMenuBarButton: UIBarButtonItem!
    var vacancyList = [VacancyList]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = defaults.value(forKey: "collegeName") as! String?
        
        sideMenuBarButton.target = self.revealViewController()
        sideMenuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
     self.tableView.addGestureRecognizer(revealViewController().panGestureRecognizer())

        collgeId = defaults.value(forKey: "collegeId") as! String!
        viewAllStudentsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {

            
        self.floatingButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.72, y: UIScreen.main.bounds.height * 0.75, width: 70, height: 70))

        self.floatingButton.setImage((UIImage(named: "01")), for: .normal)
        self.floatingButton.addTarget(self, action: #selector(HomePageTableViewController.navigateToAddChildPage), for: .touchUpInside )
        self.tableView.addSubview(self.floatingButton)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        floatingButton.removeFromSuperview()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView .isEqual(self.tableView){
            floatingButton.transform = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
        }
    }

    func navigateToAddChildPage()  {
        print("floating")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let homeCell1 = tableView.dequeueReusableCell(withIdentifier: "HomePageCell1")as! HomePageTableViewCell
        homeCell1.labelTitle.text = vacancyList[indexPath.row].vacan_Title
        homeCell1.labelExperience.text = vacancyList[indexPath.row].vacan_Experi
        homeCell1.labelLocation.text = vacancyList[indexPath.row].vacan_Location
        homeCell1.labelpostDate.text = vacancyList[indexPath.row].vacan_jobCode
        return homeCell1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vacancyDetail = self.storyboard?.instantiateViewController(withIdentifier: "VacancyDetail")as! VacancyDetailViewController
        vacancyDetail.getTitle  = vacancyList[indexPath.row].vacan_Title
        vacancyDetail.getExpReq = vacancyList[indexPath.row].vacan_Experi
        vacancyDetail.getLocation   = vacancyList[indexPath.row].vacan_Location
        vacancyDetail.getQualif = vacancyList[indexPath.row].vacan_Qualif
        vacancyDetail.getJobId  = vacancyList[indexPath.row].vacan_Id
        vacancyDetail.getjobPostDat  = vacancyList[indexPath.row].vacan_PostYear
        vacancyDetail.getJobSkill  = vacancyList[indexPath.row].vacan_Skill
        vacancyDetail.getJobDes  = vacancyList[indexPath.row].vacan_Descrip
        vacancyDetail.jobId     = vacancyList[indexPath.row].vacan_Id
        self.navigationController?.pushViewController(vacancyDetail, animated: true)
    }
    
        // MARK: - Functions to parse datas
    
    func viewAllStudentsList(){
        svProgressShow()
        serviceManager1.parseDataWithPostMethod(serviceApi: "viewvecancies") { (resData) in
            print(resData!)
            
            if resData != nil{
                if resData?["status"]as! String == "success"{
                    let studDetails = resData?["Vecancies"]as! NSArray
                    for obj in studDetails{
                        let dict = obj as! NSDictionary
                        self.vacancyList.append(VacancyList.init(vacTitle: dict["job_title"]as! String, vacExperi: dict["experience_from"]as! String, vacLoc: dict["job_location"]as! String, vacPostYr: dict["posted_date"]as! String,vacId: dict["id"]as! String,vacQuali: dict["qualification"]as! String,vacExpTo:dict["experience_to"]as! String,jobCode:dict["job_code"]as! String,vacDescri:dict["job_description"]as! String,vacSkill:dict["prefered_skills"]as! String))
                    }
                    self.tableView.reloadData()
                    svProgressDismiss()
                }else{
                    svProgressDismiss()
                    AlertContolClass.alertContol(alertTitle: "Error", alertMessage: resData?["status"]as! String, VC: self)
                }
            }
        }
    }
    
}


class VacancyList{
    var vacan_Title         :   String!
    var vacan_ExperiFrom    :   String!
    var vacan_ExperiTo      :   String!
    var vacan_Location      :   String!
    var vacan_PostYear      :   String!
    var vacan_Id            :   String!
    var vacan_Qualif        :   String!
    var vacan_Descrip       :   String!
    var vacan_Skill         :   String!
    var vacan_jobCode       :   String!
    
    
    var vacan_Experi        :   String!
    
    init(vacTitle:String,vacExperi:String,vacLoc:String,vacPostYr:String,vacId:String,vacQuali:String,vacExpTo:String,jobCode:String,vacDescri:String,vacSkill:String) {
        
        vacan_Title     = vacTitle
        vacan_ExperiFrom    = vacExperi
        vacan_Location   = vacLoc
        vacan_PostYear  = vacPostYr
        vacan_Id        = vacId
        vacan_Qualif    = vacQuali
        vacan_ExperiTo  = vacExpTo
        vacan_jobCode   = jobCode
        vacan_Descrip   = vacDescri
        vacan_Skill     = vacSkill
        
        vacan_Experi = vacan_ExperiFrom + "-" + vacan_ExperiTo + " " + "year"
    }
}
