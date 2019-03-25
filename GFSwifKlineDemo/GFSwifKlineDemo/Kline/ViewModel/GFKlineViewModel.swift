//
//  GFKlineViewModel.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

typealias successVMCallBack = (_ jsonData:JSON) -> Void

typealias failureVMCallBack = (_ error:Error) -> Void

class GFKlineViewModel: NSObject {
    
    
    func request(type: MethodType,url:String,parameters:Parameters? = nil, successCallBack:@escaping  successCallBack,failureCallBack:@escaping failureCallBack){
        
        var encodingMethod:ParameterEncoding?
        encodingMethod = JSONEncoding.default
        //      encodingMethod = URLEncoding.default
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(hostName + url, method: method, parameters: parameters, encoding: encodingMethod!, headers: header).responseJSON { (responseObject) in
            switch responseObject.result {
                
            case .success:
                
                if let value = responseObject.result.value {
                    let jsonData = JSON(value)
                    successCallBack(jsonData)
                }
                
            case .failure(let error):
                failureCallBack(error)
            }
        }
        
    }
    
}
