//
//  CompanyListViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 14/11/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class CompanyListViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var companyList =   [Companies]()
    
    @IBOutlet var sideBar: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideBar.target = self.revealViewController()
        sideBar.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        gettingCompanyDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)as! CollectionViewCell
        cell.lbl.text = companyList[indexPath.item].cmpny_Name
        cell.locLabel.text  =   companyList[indexPath.item].cmpny_Location
        cell.comTypelabel.text  =   companyList[indexPath.item].cmpny_Type
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let companyDetail = self.storyboard?.instantiateViewController(withIdentifier: "CompanyDetail")as! CompanyDetailTableViewController
        companyDetail.getCompName = companyList[indexPath.item].cmpny_Name
        companyDetail.getAddress = companyList[indexPath.item].cmpny_Location
        companyDetail.getAbtCmpny = companyList[indexPath.item].cmpny_Type
        companyDetail.getWebsite    = companyList[indexPath.item].website_url
        
        self.navigationController?.pushViewController(companyDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        return CGSize(width: view.bounds.width - 5, height:layout.itemSize.height)
    }
    
    
    func gettingCompanyDetails(){
        svProgressShow()
        serviceManager1.parseDataWithPostMethod(serviceApi: "viewcompanies") { (resData) in
            if resData != nil{
            print(resData!)
                if resData?["status"]as! String == "success"{
                    let collData = resData?["Company_Details"]as! NSArray
                    for obj in collData{
                        let dict = obj as! NSDictionary
                        self.companyList.append(Companies(comName: dict["company_name"]as! String, comLoc: dict["company_address"]as! String, comType: dict["company_about"]as! String, website:dict["website_url"]as! String))
                    }
                    svProgressDismiss()
                    self.collectionView.reloadData()
                }else{
                    svProgressDismiss()
                    AlertContolClass.alertContol(alertTitle: "Error", alertMessage: resData?["status"]as! String, VC: self)
                }
            }
        }
    }
}

class Companies{
    var cmpny_Name      :   String!
    var cmpny_Location  :   String!
    var cmpny_Type      :   String!
    var website_url     : String!
    
    init(comName:String,comLoc:String,comType:String,website:String) {
        self.cmpny_Name =   comName
        self.cmpny_Location =   comLoc
        self.cmpny_Type =   comType
        self.website_url    =   website
    }
    
}
