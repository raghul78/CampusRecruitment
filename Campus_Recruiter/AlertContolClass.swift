//
//  AlertContolClass.swift
//  Peekab
//
//  Created by APPLE on 03/05/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit

class AlertContolClass: NSObject {
// Function for alertcontroller
    class func alertContol(alertTitle:String,alertMessage:String,VC:UIViewController){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addAct = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(addAct)
    
     VC.present(alert, animated: true, completion: nil)
    }
// Function for alertcontroller with block (one button)
    class func alertContolWithBlock(alertTitle:String,alertMessage:String,VC:UIViewController,block:@escaping ((UIAlertAction) ->Void)){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addAct = UIAlertAction(title: "OK", style: .default) { (actionBlock) in
            block(actionBlock)
        }
        alert.addAction(addAct)
        
        VC.present(alert, animated: true, completion: nil)
    }
    
// Function for alertcontroller with block (two button)
    class func alertContolWithTwoButtonBlock(alertTitle:String,alertMessage:String,VC:UIViewController,blockOne:@escaping ((UIAlertAction) ->Void)){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addAct = UIAlertAction(title: "Exit", style: .default) { (actionBlock1) in
           blockOne(actionBlock1)
        }
        let addAction2  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAct)
        alert.addAction(addAction2)
        
        VC.present(alert, animated: true, completion: nil)
    }
    
// Function for alertcontroller with Actionsheet
    class func alertControllerWithActionSheet(VC:UIViewController){
        
        let pickImage = UIImagePickerController()
        let actionSheet = UIAlertController(title: "", message: "Select your option", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            pickImage.sourceType = .camera
            VC.present(pickImage, animated: true, completion: nil)
        })
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
            pickImage.sourceType = .photoLibrary
            VC.present(pickImage, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        actionSheet.addAction(camera)
        actionSheet.addAction(gallery)
        actionSheet.addAction(cancel)
        VC.present(actionSheet, animated: true, completion: nil)
    }
    
}
