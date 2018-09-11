//
//  StudentDetailViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 26/12/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {

    var getStudId       : String!
    var getStudName     : String!
    var getStudEmail    : String!
    var getStudQualif   : String!
    var getStudPassYr   : String!
    var getStudContct   : String!
    var getImage        :UIImage!
    
    @IBOutlet var profImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var pasOutLabel: UILabel!
    @IBOutlet var QualifLabel: UILabel!
    @IBOutlet var whiteView: UIView!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var emailButton: UIButton!
    
    let messageComposer = MessageComposer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Student Detail"
        // Do any additional setup after loading the view.
        print(getStudId)
        nameLabel.text  = getStudName
        emailLabel.text = getStudEmail
        pasOutLabel.text    = getStudPassYr
        QualifLabel.text    = getStudQualif
        profImageView.image = getImage
        
        profImageView.layer.cornerRadius    = 50
        profImageView.layer.borderColor = UIColor().lightPinkClr().cgColor
        profImageView.layer.borderWidth = 2.0
        
        whiteView.layer.cornerRadius = 10
        callButton.layer.cornerRadius = 30
        emailButton.layer.cornerRadius = 30
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emailAction(_ sender: Any) {
        
        let mailComposeViewController = messageComposer.configuredMailComposeViewController(sendToEmail: getStudEmail)
        if messageComposer.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
             AlertContolClass.alertContol(alertTitle: "Cannot Send Email", alertMessage: "Your device is not able to Email.", VC: self)
        }
        
//        if (messageComposer.canSendText()) {
//            // Obtain a configured MFMessageComposeViewController
//            
//            let messageComposeVC = messageComposer.configuredMessageComposeViewController(sendTo: [getStudEmail])
//            
//            present(messageComposeVC, animated: true, completion: nil)
//        } else {
//            
//            // send text messages
//            AlertContolClass.alertContol(alertTitle: "Cannot Send Text Message", alertMessage: "Your device is not able to send text messages.", VC: self)
//        }
        
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
