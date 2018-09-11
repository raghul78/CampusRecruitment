//
//  ControlsDesign.swift
//  Parent
//
//  Created by APPLE on 22/06/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD

class ControlsDesign: NSObject {
    
    
    class func designOfTextfieldwithButtomBorder(txtFld:[UITextField], borderClr:UIColor)
    {
        for txtField in txtFld {
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0.0, y: txtField.frame.height - 1, width: txtField.bounds.width, height: 1.5)
        print(txtField.bounds.width)
        bottomLine.backgroundColor = borderClr.cgColor
        txtField.borderStyle = UITextBorderStyle.none
        
        txtField.layer.addSublayer(bottomLine)
        txtField.layer.masksToBounds = false
        }
    }
    
}
extension UITextField {
    func setBottomBorder(clr:UIColor,height:CGFloat) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = clr.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: height )
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}


/** Extension class to SkyBlue color */
extension UIColor{
    func getSkyBlueColor() -> UIColor{
        return UIColor(red: 0/255, green: 200/255, blue: 255/255, alpha: 1)
    }
}

/** Extension class to get red color */
extension UIColor{
    func getredColor() -> UIColor{
        return UIColor(red: 255/255, green: 0/255, blue: 59/255, alpha: 1)
    }
}


/** Extension class to get light gray color */

extension UIColor{
    func blueClr()->UIColor{
        return UIColor(red: 238/255, green: 42/255, blue: 122/255, alpha: 0.95)
    }
}

extension UIColor {
    func lightPinkClr()->UIColor{
        return UIColor(red: 237/255, green: 42/255, blue: 125/255, alpha: 0.5)
    }
}
/** Sidemenu title label */
extension UILabel{
    func labelBorder(){
        layer.cornerRadius = 20
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }
}

func svProgressShow(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.setForegroundColor(UIColor().blueClr())
}

func svProgressDismiss(){
    SVProgressHUD.dismiss()
}
