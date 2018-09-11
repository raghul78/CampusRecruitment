//
//  RegistrationTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 26/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit
import SVProgressHUD
import DropDown

class RegistrationTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    var getCollId   : String!
    let desigArray  = ["Principal","Professor","Asst.Professor","Lecturer","Sr.Lecturer"]
    var getCollName : String!
    var getContNo   : String!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var subView: UIView!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtfldCollName: UITextField!
    @IBOutlet var txtfldContactNo: UITextField!
    @IBOutlet var txtfldEmailId: UITextField!
    @IBOutlet var txtfldPassword: UITextField!
    @IBOutlet var txtfldCnfmPass: UITextField!
    @IBOutlet var txtfldDesgnation: UITextField!
    @IBOutlet var drop: UIDropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.layer.cornerRadius = 25
        subView.layer.borderWidth = 2.0
        subView.layer.borderColor = UIColor.white.cgColor
        txtfldDesgnation.inputView = pickerView
        txtfldCollName.text = getCollName
        txtfldContactNo.text = getContNo
        txtfldContactNo.isEnabled = false
        txtfldCollName.isEnabled = false
      //  showDropdownList()
        
        tapGestureToResignTxtfld(VC: self, action: #selector(textfieldResign))
    }

    @IBAction func submitAction(_ sender: Any) {
        
        if (txtFldName.text?.isEmpty)! || (txtfldEmailId.text?.isEmpty)! || (txtfldCnfmPass.text?.isEmpty)! || (txtfldDesgnation.text?.isEmpty)!{
           
            AlertContolClass.alertContolWithBlock(alertTitle: "Alert", alertMessage: "Some fields are empty", VC: self, block: { (alrt) in
                if self.txtFldName.text == ""{
                    self.txtFldName.becomeFirstResponder()
                    self.animateTxtFldWithShake(txtfld: self.txtFldName)
                }else if self.txtfldEmailId.text == "" {
                    self.txtfldEmailId.becomeFirstResponder()
                    self.animateTxtFldWithShake(txtfld: self.txtfldEmailId)
                }else if self.txtfldPassword.text == ""{
                    self.txtfldPassword.becomeFirstResponder()
                    self.animateTxtFldWithShake(txtfld: self.txtfldPassword)
                }else if self.txtfldCnfmPass.text == ""{
                    self.txtfldCnfmPass.becomeFirstResponder()
                    self.animateTxtFldWithShake(txtfld: self.txtfldCnfmPass)
                }else {
                    self.txtfldDesgnation.becomeFirstResponder()
                    self.animateTxtFldWithShake(txtfld: self.txtfldDesgnation)
                }
            })
            
        }else if emailValidation(textEmail: txtfldEmailId.text!) == false {
            txtfldEmailId.becomeFirstResponder()
            AlertContolClass.alertContolWithBlock(alertTitle: "Invalid Email", alertMessage: "Email Id must be in correct format", VC: self, block: { (alrt) in
                self.animateTxtFldWithShake(txtfld: self.txtfldEmailId)
            })
        }else if txtfldPassword.text! != txtfldCnfmPass.text! {
            txtfldPassword.becomeFirstResponder()
            AlertContolClass.alertContolWithBlock(alertTitle: "Error", alertMessage: "Password field and confirm password fields are not matching.", VC: self, block: { (alrt) in
                self.animateTxtFldWithShake(txtfld: self.txtfldCnfmPass)
            })
        }else{
            svProgressShow()
            registerNewUser()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "loginPage", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//Mark:- TableView Datasource
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundView = UIImageView(image: UIImage(named: "login2"))
       // cell.backgroundColor = UIColor.clear

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height * 0.1
        }
        return UIScreen.main.bounds.height * 0.9
    }
    
// Pickerview Datasource and Delegate methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return desigArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return desigArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtfldDesgnation.text = desigArray[row]
    }
    
  // function to animate textfield
    func animateTxtFldWithShake(txtfld:UITextField){
        let animLayer = CABasicAnimation(keyPath: "position")
        animLayer.duration = 0.05
        animLayer.repeatCount = 7
        animLayer.autoreverses = true
        animLayer.fromValue = NSValue(cgPoint: CGPoint(x: txtfld.center.x - 15, y: txtfld.center.y))
        animLayer.toValue   = NSValue(cgPoint: CGPoint(x: txtfld.center.x + 15, y: txtfld.center.y))
        txtfld.layer.add(animLayer, forKey: "position")

    }
    
// Function to create Dropdown list
    func showDropdownList(){
       // let drop = UIDropDown(frame: CGRect(x: 0 , y: 0, width: txtfldDesgnation.frame.width, height: 35))
       // drop.center = CGPoint(x: txtfldDesgnation.frame.midX, y: txtfldDesgnation.frame.midY)
        drop.placeholder = "Designation"
        drop.options = ["Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
        drop.didSelect { (elem, index) in
            print(elem)
            self.txtfldDesgnation.text = elem
        }
      //  txtfldDesgnation.addSubview(drop)
       // self.view.addSubview(drop)
    }
// Function to parse registration Details
    func registerNewUser(){

        let param = "college_id=\(getCollId!)&name=\(txtFldName.text!)&email=\(txtfldEmailId.text!)&password=\(txtfldCnfmPass.text!)&position=\(txtfldDesgnation.text!)"
        print(param)
        serviceManager1.parseDataWithPostMethod(serviceApi: "register", param: param) { (resData) in
            if resData != nil{
            if resData?["status"]as! String == "success"{
            print(resData!)
            self.performSegue(withIdentifier: "loginPage", sender: self)
            SVProgressHUD.dismiss()
            }else{
            AlertContolClass.alertContol(alertTitle: "Failed.", alertMessage: resData?["status"]as! String, VC: self)
            }
        }
        }
    }
    
    func textfieldResign(){
        txtFldName.resignFirstResponder()
        txtfldCollName.resignFirstResponder()
        txtfldContactNo.resignFirstResponder()
        txtfldEmailId.resignFirstResponder()
        txtfldPassword.resignFirstResponder()
        txtfldCnfmPass.resignFirstResponder()
        txtfldDesgnation.resignFirstResponder()
    }
}

extension UITextField{
    @IBInspectable var placeholderClr:UIColor?{
        get{
            return self.placeholderClr
        }
        set{
            return self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSForegroundColorAttributeName : newValue!])
        }
    }
}
