//
//  WebsiteViewController.swift
//  Campus_Recruiter
//
//  Created by Srishti Innovative Private Limited on 02/01/18.
//  Copyright © 2018 srishti. All rights reserved.
//

import UIKit

class WebsiteViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet var website: UIWebView!
    @IBOutlet var actvityInd: UIActivityIndicatorView!
    var kweb    : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        website.delegate = self
        // Do any additional setup after loading the view.
        website.loadRequest(URLRequest(url: URL(string: kweb)!))
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        actvityInd.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        actvityInd.stopAnimating()
        actvityInd.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
