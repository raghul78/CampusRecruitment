//
//  ViewStudentsTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 30/12/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class ViewStudentsTableViewController: UITableViewController {

    @IBOutlet var sideBarMenu: UIBarButtonItem!
    var studentsList = [StudentsList]()
    var filteredStudList = [StudentsList]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredStudList = studentsList
        sideBarMenu.target = self.revealViewController()
        sideBarMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.tableView.addGestureRecognizer(revealViewController().panGestureRecognizer())
        searchDisplayContoller()
        viewAllStudentsList()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: true, completion: nil)
        searchController.searchBar.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredStudList.count
        }        
        return studentsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudListCell", for: indexPath)as! StudentListTableViewCell

        let model: StudentsList
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredStudList[indexPath.row]
        } else {
            model = studentsList[indexPath.row]
        }
        cell.labelYear.text = model.stud_year
        cell.labelName.text = model.stud_Name
        cell.labelEmail.text   = model.stud_email
        
        let url = URL(string: model.stud_Image)
        cell.studProfImage.sd_setImage(with: url, placeholderImage: UIImage(named:"splash"), options: .highPriority, completed: nil)
    
        return cell
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)as! StudentListTableViewCell
        let  studentDetail = self.storyboard?.instantiateViewController(withIdentifier: "StudentDetail")as! StudentDetailViewController
        let model: StudentsList
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredStudList[indexPath.row]
        } else {
            model = studentsList[indexPath.row]
        }
        studentDetail.getStudId = model.stud_Id
        studentDetail.getStudName   = model.stud_Name
        studentDetail.getStudPassYr = model.stud_year
        studentDetail.getStudEmail  = model.stud_email
        studentDetail.getStudQualif = model.stud_Qualif
        studentDetail.getImage = cell.studProfImage.image
        self.navigationController?.pushViewController(studentDetail, animated: true)
    }

    func viewAllStudentsList(){
        svProgressShow()
        let param = "collegeid=1"
        print(param)
        serviceManager1.parseDataWithPostMethod(serviceApi: "viewallstudent", param: param) { (resData) in
            print(resData!)
            
            if resData != nil{
                if resData?["status"]as! String == "success"{
                    let studDetails = resData?["Student_Details"]as! NSArray
                    for obj in studDetails{
                        let dict = obj as! NSDictionary
                        self.studentsList.append(StudentsList.init(studName: dict["user_name"]as! String, studImage: dict["picture_url"]as! String, studEmail: dict["user_emailid"]as! String, studYear: dict["passout_year"]as! String,studId: dict["user_id"]as! String,studQuali: dict["qualification"]as! String))
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
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredStudList = studentsList.filter({( model : StudentsList) -> Bool in
            return model.stud_year.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchDisplayContoller(){
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by year"
        tableView.tableHeaderView = searchController.searchBar
    }
}

extension ViewStudentsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}

class StudentsList{
    var stud_Name   :   String!
    var stud_Image  :   String!
    var stud_email  :   String!
    var stud_year   :   String!
    var stud_Id     :   String!
    var stud_Qualif :   String!
    
    init(studName:String,studImage:String,studEmail:String,studYear:String,studId:String,studQuali:String) {
        self.stud_Name  = studName
        self.stud_Image = studImage
        self.stud_email = studEmail
        self.stud_year  =   studYear
        self.stud_Id    =   studId
        self.stud_Qualif    =   studQuali
    }
}
