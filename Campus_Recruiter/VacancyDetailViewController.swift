//
//  VacancyDetailViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 30/12/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class VacancyDetailViewController: UIViewController {
    
    var getTitle        : String!
    var getExpReq       : String!
    var getLocation     : String!
    var getQualif       : String!
    var getJobDes       : String!
    var getJobSkill     : String!
    var getJobId        : String!
    var getjobPostDat   : String!
    
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelExperience: UILabel!
    @IBOutlet var labelLocation: UILabel!
    @IBOutlet var labelQualifi: UILabel!
    @IBOutlet var labelPostDate: UILabel!
    @IBOutlet var txtviewDescription: UITextView!
    @IBOutlet var txtviewSkill: UITextView!
    @IBOutlet var whiteView: UIView!
    
    var jobId   : String!
    var watsappLink : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text         = getTitle
        labelExperience.text    = getExpReq
        labelLocation.text     = getLocation
        labelQualifi.text       = getQualif
        labelPostDate.text      = getjobPostDat
        txtviewDescription.text = getJobDes
        txtviewSkill.text       = getJobSkill
        
        whiteView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareBarButtonAction(_ sender: Any) {
        

        
        let actionSht = UIAlertController(title: "Share With", message: "", preferredStyle: .actionSheet)
        actionSht.addAction(UIAlertAction(title: "Watsapp", style: .default, handler: { (actn) in
    
            let escapedString = "whatsapp://send?text=www.itjobcell.com/jobs/view/" + self.jobId
            
            print(escapedString)
            
        if let whatsappURL = URL(string: escapedString) {
            
            if UIApplication.shared.canOpenURL(whatsappURL)
            {

                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                
            } else {
                print("Cannot open whatsapp")
                // Cannot open whatsapp
                
            }
        }
    }))
        actionSht.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSht, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
