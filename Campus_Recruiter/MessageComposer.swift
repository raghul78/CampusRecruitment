//
//  MessageComposer.swift
//  composerMail
//
//  Created by Srishti on 15/10/1939 Saka.
//  Copyright © 1939 Saka Srishti. All rights reserved.
//

import Foundation
import MessageUI
let textMessageRecipients = ["raghul.r78@gmail.com"]
class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    
    func configuredMessageComposeViewController(sendTo:[String]) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        //  Make sure to set this property to self, so that the controller can be dismissed!
        
        messageComposeVC.recipients = sendTo
       messageComposeVC.body = "Hey friend - Just sending a text message in-app using Swift!"
        return messageComposeVC
    }
    
    
    // Configures and returns a MFMailComposeViewController instance
    
    func configuredMailComposeViewController(sendToEmail:String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([sendToEmail])
        mailComposerVC.setSubject("From Placement officer")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MFMailComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
