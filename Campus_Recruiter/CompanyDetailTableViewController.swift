//
//  CompanyDetailTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 01/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class CompanyDetailTableViewController: UITableViewController {

    var getCompName     : String!
    var getAddress      : String!
    var getAbtCmpny     : String!
    var getWebsite      : String!
    
    
    @IBOutlet var labelCompName: UILabel!
    @IBOutlet var labelAddress: UILabel!
    @IBOutlet var labelAbtCmpny: UILabel!

    @IBOutlet var websiteBut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCompName.text      = getCompName
        labelAddress.text       = getAddress
        labelAbtCmpny.text      = getAbtCmpny
        websiteBut.setTitle(getWebsite, for: .normal)

    }
    
    @IBAction func webButActn(_ sender: Any) {
        let websitePage = self.storyboard?.instantiateViewController(withIdentifier: "website")as! WebsiteViewController
        websitePage.kweb = getWebsite
        self.navigationController?.pushViewController(websitePage, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



}
