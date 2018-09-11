//
//  LoginPageTableViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 26/10/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

let serviceManager = AlamofireParsingGetMethod()
let serviceManager1 = AlamofireDataParsing1()

let defaults = UserDefaults.standard

class LoginPageTableViewController: UITableViewController {

    @IBOutlet var userNameTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var usrNameImage: UIImageView!
    @IBOutlet var passwordImage: UIImageView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var hideShowButton: UIButton!
    @IBOutlet var eyeButton: UIButton!
    
    var cancel = UIAlertAction()
    
    
    var isShowPassword   = true
    var collName : String!
    var contactNum  : String!
    var collId  : String!
    var collegeDetails = [CollegeDetails]()
    var officerDetails  = [OfficerDetails]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlDesisigns()
        jknj()
        tapGestureToResignTxtfld(VC: self, action: #selector(resignTextField))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       // tableView.backgroundView = UIImageView(image: UIImage(named: "login1"))
        cell.backgroundColor = UIColor.clear
        cell.backgroundView = UIImageView(image: UIImage(named: "login1"))
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    @IBAction func loginAction(_ sender: Any) {
       
        if (userNameTextfield.text?.isEmpty)! || (passwordTextfield.text?.isEmpty)!{
            
            AlertContolClass.alertContol(alertTitle: "Alert", alertMessage: "Some fields are empty.", VC: self)
        }else if emailValidation(textEmail: userNameTextfield.text!) == false{
            AlertContolClass.alertContol(alertTitle: "Alert", alertMessage: "Invalid Email Id", VC: self)
        }else{
            svProgressShow()
            performLogin()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveRegisterPage"{
            let RegVC = segue.destination as! RegistrationTableViewController
            RegVC.getCollName = collegeDetails[0].collegeName
            RegVC.getContNo = collegeDetails[0].contactNum
            RegVC.getCollId = collegeDetails[0].id
        }
    }
    
    func resignTextField(){
        userNameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let alert = UIAlertController(title: "College key", message: "Enter the uinque key.", preferredStyle: .alert)
        alert.addTextField { (txtfld) in
            txtfld.placeholder = "Enter the key."
            
        self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(self.cancel)
            let next = UIAlertAction(title: "Next", style: .default, handler: { (alrt) in
                
                if txtfld.text != ""{
                svProgressShow()
                let param = "collegekey=\(txtfld.text!)"
                print(param)
              serviceManager1.parseDataWithPostMethod(serviceApi: "collegekey", param: param, compltionBlock: { (responceData) in
                if responceData != nil{
                print(responceData!)
                SVProgressHUD.dismiss()
                    if responceData?["Status"]as! String == "success"{
                        let collDetail = responceData?["CollegeDetails"] as! NSArray
                        for obj in collDetail{
                            let dict = obj as! NSDictionary
                            self.collegeDetails.append(CollegeDetails(coll_Name: dict["college_name"]as! String, con_Num: dict["college_phone"]as! String, id: dict["id"]as! String))
                        }
                    self.performSegue(withIdentifier: "moveRegisterPage", sender: self)
                        
                    }else{
                        AlertContolClass.alertContol(alertTitle: "Error", alertMessage: "Invalid College key", VC: self)
                    }
                }
              })
            }
            })
            alert.addAction(next)
        }
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func passShowHide(_ sender: UIButton) {
        if isShowPassword == true{
             sender.setImage(UIImage(named: "eyeHide"), for: .normal)
            isShowPassword = false
            passwordTextfield.isSecureTextEntry = true
        }else{
            sender.setImage(UIImage(named: "eyeShow"), for: .normal)
            isShowPassword = true
            passwordTextfield.isSecureTextEntry = false
        }
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        let alert = UIAlertController(title: "Forget Password", message: "Enter your valid email Id to get your password.", preferredStyle: .alert)
        alert.addTextField { (textFld) in
            textFld.placeholder = "Email Id"
            self.cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(self.cancel)
            let send = UIAlertAction(title: "Send", style: .default, handler: { (sendAction) in
                svProgressShow()
                if textFld.text != ""{
                    self.performForgetPassword(txtFld: textFld.text!)
                }
            })
            alert.addAction(send)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
 // MARK: - Functions for Data Parsing
    
    func performLogin(){
        let param1 = "email=\(userNameTextfield.text!)&password=\(passwordTextfield.text!)"
        print(param1)
        
        serviceManager1.parseDataWithPostMethod(serviceApi: "login", param: param1) { (responceData) in
            
            if responceData != nil{
                print(responceData!)
                if responceData?["status"]as! String == "success"{
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "revealSegue", sender: self)
                    let offDetailArray = responceData?["PlacementOfficer_Details"]as! NSArray
                    for obj in offDetailArray{
                        let dict = obj as! NSDictionary
                        self.officerDetails.append(OfficerDetails(off_id: dict["officer_id"]as! String, off_name: dict["officer_name"]as! String, coll_Id: dict["officer_college_id"]as! String, off_email: dict["officer_email"]as! String, coll_Name:dict["college_name"]as! String))
                    }
                defaults.set(self.officerDetails[0].collegeId, forKey: "collegeId")
                defaults.setValue(self.officerDetails[0].collNameSplit, forKey: "collegeName")
                }else{
                    SVProgressHUD.dismiss()
                    AlertContolClass.alertContol(alertTitle: "Error", alertMessage: responceData?["status"]as! String, VC: self)
                }
            }
        }
    }
    
    func performForgetPassword(txtFld:String){
        let param = "email=\(txtFld)"
        serviceManager1.parseDataWithPostMethod(serviceApi: "forgetpassword", param: param) { (resData) in
            if resData != nil{
                SVProgressHUD.dismiss()
                if resData?["status"]as! String == "success"{
                    AlertContolClass.alertContol(alertTitle: "Success", alertMessage: "Check your email to recover your password.", VC: self)
                }else{
                     AlertContolClass.alertContol(alertTitle: "Error", alertMessage: "Entered email id is not valid.", VC: self)
                }
            }
        }
    }
    
 // MARK: - Functions to handle textfield designs.
    func controlDesisigns(){
        userNameTextfield.layer.cornerRadius = 20
        passwordTextfield.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        userNameTextfield.layer.borderWidth = 1
        userNameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextfield.layer.borderWidth = 1
        passwordTextfield.layer.borderColor = UIColor.lightGray.cgColor
        usrNameImage.layer.cornerRadius = 15
        usrNameImage.clipsToBounds = true
        passwordImage.layer.cornerRadius = 15
        passwordImage.clipsToBounds = true

    }
    func jknj(){
        let eyeB = UIButton(type: .custom)
        eyeB.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        eyeB.layer.backgroundColor = UIColor.clear.cgColor

        let paddingView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(eyeB)
        passwordTextfield.rightView = paddingView
        passwordTextfield.rightViewMode = .always
        
        let passwordImg = UIImageView(frame: CGRect(x: 5, y: 0, width: 30, height: 30))
        passwordImg.image = UIImage(named: "password")
        passwordImg.layer.cornerRadius = 15
        passwordImg.clipsToBounds = true
        let paddingView1:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView1.addSubview(passwordImg)
        passwordTextfield.leftView = paddingView1
        passwordTextfield.leftViewMode = .always
    }
}

    // MARK: - Model Class to handle College Details
class CollegeDetails{
    
    var collegeName : String!
    var contactNum  : String!
    var id          : String!
    
    init(coll_Name:String,con_Num:String,id:String) {
        self.collegeName = coll_Name
        self.contactNum = con_Num
        self.id = id
    }
}

// MARK: - Model Class to handle College Details
class OfficerDetails{
    var officerId       :   String!
    var officerName     :   String!
    var collegeId       :   String!
    var officerEmail    :   String!
    var college_Name    :   String!
    var collNameSplit   : String!
    
    init(off_id:String,off_name:String,coll_Id:String,off_email:String,coll_Name:String) {
        self.collegeId  = off_id
        self.officerName    = off_name
        self.collegeId  = coll_Id
        self.officerEmail   = off_email
        self.college_Name   = coll_Name
        
        collNameSplit = college_Name.components(separatedBy: ",")[0]
    }
}
