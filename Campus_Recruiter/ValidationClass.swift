
//
//  ValidationClass.swift
//  Peekab
//
//  Created by APPLE on 02/05/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import Foundation
import UIKit

let usrDefaults = UserDefaults.standard
var childIdGlobal = String()
let pickImageController = UIImagePickerController()

/**Function Email validation created by raghul */
func emailValidation(textEmail:String)->Bool{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: textEmail)
    
}


/**Function Phone number validation */
func phoneValidate(value: String) -> Bool {
    let PHONE_REGEX = "^\\d{10}$"//\\d{3}\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}


/**Function Password validation */
func passwordValidation(value: String) -> Bool{
    let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", password)
    let result =  phoneTest.evaluate(with: value)
    return result
}

/**Function to limit textfield data */
func textfieldLimits(txtFldName:String)->Bool{
    let charSet = CharacterSet.decimalDigits
    let decimalRange = txtFldName.rangeOfCharacter(from: charSet, options: [], range: nil)
    return (decimalRange != nil)
    
}


/** Function to recognize tap gesture */
func tapGestureToResignTxtfld(VC:UIViewController,action:Selector){
    let tap = UITapGestureRecognizer(target: VC, action: action)
    VC.view.addGestureRecognizer(tap)
}
 
/** Extension class to pop viewcontroller */
extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
}


/** Function to get Date and Time */
var getCurrentTime:()->String = {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:ss a"
  return formatter.string(from: date)
}


/** Function to get Date */
var getCurrentDate:()->String = {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}


/**Function to pick image with actionsheet */

func performActionWithImagePickcer(VC:UIViewController) {
let actionSheet = UIAlertController(title: "", message: "Select your option", preferredStyle: .actionSheet)
    let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
        pickImageController.sourceType = .camera
        VC.present(pickImageController, animated: true, completion: nil)
    }
    let gallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
        pickImageController.sourceType = .photoLibrary
        VC.present(pickImageController, animated: true, completion: nil)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    actionSheet.addAction(camera)
    actionSheet.addAction(gallery)
    actionSheet.addAction(cancel)
    VC.present(actionSheet, animated: true, completion: nil)
}
