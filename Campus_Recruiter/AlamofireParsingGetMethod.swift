//
//  AlamofireParsingGetMethod.swift
//  QRBusStop
//
//  Created by Srishti Innovative Private Limited on 14/08/17.
//  Copyright © 2017 srishti. All rights reserved.
//

import UIKit
import Alamofire

protocol DataHandle {
    func receiveDataFromDataModel(data:AnyObject)
}

class AlamofireParsingGetMethod: NSObject {
    var delegate : DataHandle!
    
    let baseApi = "http://itjobcell.com/apis/index.php/"

    func parseDataWithGetMethod(serviceApi:String,param:[String:AnyObject],compltionBlock:@escaping (AnyObject?)->Void){
        
        request((baseApi+serviceApi),parameters:param).responseJSON { (responseData) in
            compltionBlock(responseData.result.value as AnyObject)
        }
    }
    
    func parseDataWithPostMethod(serviceApi:String,param:[String:AnyObject]){
        request((baseApi+serviceApi), method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in

            self.delegate.receiveDataFromDataModel(data: responseData.result.value as AnyObject)
        }
    }

    func parseDataWithPost(serviceApi:String,param:[String:String],compltionBlock:@escaping (AnyObject?)->Void){
        
        request((baseApi+serviceApi), method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in
            compltionBlock(responseData.result.value as AnyObject?)
        }
    }
        
    func parseDataWithDelegate(serviceApi:String,param:[String:AnyObject]){
        request((baseApi+serviceApi),parameters:param).responseJSON { (responseData) in
            self.delegate.receiveDataFromDataModel(data: responseData.result.value as AnyObject)
        }
    }
    
    // Function to parse data with header
    
    func parseDataWithHeader(serviceUrl:String,param:[String:String],block:@escaping (AnyObject?)->Void){
        
        request((self.baseApi+serviceUrl), method: .post, parameters: param, encoding: JSONEncoding.default, headers:["Content-Type":"application/x-www-form-urlencoded"]).responseJSON { (response) in
            block(response.result.value as AnyObject)
        }
    }
    
}
