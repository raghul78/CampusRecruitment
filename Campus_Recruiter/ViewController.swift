//
//  ViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 20/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtFldUserName: SkyFloatingLabelTextField!
    @IBOutlet var txtFldPassword: SkyFloatingLabelTextField!
    @IBOutlet var bgViewbottomLayout: NSLayoutConstraint!
    
    @IBOutlet var bgImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtFldUserName.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
           self.bgViewbottomLayout.constant = 50
            self.bgImageView.frame.origin.y = self.bgImageView.frame.origin.y - 100
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(_ sender: Any) {
        performSegue(withIdentifier: "revealSegue", sender: self)
    }

    @IBAction func registerAction(_ sender: Any) {
        performSegue(withIdentifier: "moveRegisterPage", sender: self)
    }
}

