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
    
    func requestKlineData(type: MethodType,url:String,parameters:Parameters? = nil, successVMCallBack:@escaping  successVMCallBack,failureVMCallBack:@escaping failureVMCallBack){
        
        GFKlineNetworkTools.request(type: .GET, url: url, parameters: parameters, successCallBack: { (json) in
            successVMCallBack(json)
        }) { (error) in
            failureVMCallBack(error)
        }
        
    }
    
}
