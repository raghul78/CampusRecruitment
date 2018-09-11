//
//  AlamofireDataParsing.swift
//  Alomafire
//
//  Created by APPLE on 27/04/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class AlamofireDataParsing1: NSObject {

    let baseAPI = "http://itjobcell.com/apis/index.php/"
    let posts = HTTPMethod.post
    
    let headers = ["Content-Type":"Application/json"]
    
    
// Function for POST method
    func parseDataWithPostMethod(serviceApi:String,param:String,compltionBlock:@escaping (AnyObject?)->Void){
        var request = URLRequest(url: URL(string: (baseAPI+serviceApi))!)
        request.httpMethod = "POST"
        request.httpBody = param.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
            do{
                let myData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                compltionBlock(myData as AnyObject?)
            
            }catch{
                print(error.localizedDescription)
            }
        }
        }
        task.resume()
    }
    
// Function for POST method without parameter

    func parseDataWithPostMethod(serviceApi:String,compltionBlock:@escaping (AnyObject?)->Void){
        var request = URLRequest(url: URL(string: (baseAPI+serviceApi))!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do{
                    let myData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    compltionBlock(myData as AnyObject?)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
  // Function for POST method with Alamofire
    func parseDataWithPostAlamofire(serviceApi:String,param:[String:String],compltionBlock:@escaping (AnyObject?)->Void){
        
        request(serviceApi, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in
            compltionBlock(responseData.result.value as AnyObject?)
            print(serviceApi)
            print(param)
        }
    }
    
}
