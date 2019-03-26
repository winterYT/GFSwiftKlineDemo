//
//  GFKlineNetworkTools.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

enum MethodType {
    case GET
    case POST
}

enum RequestType:Int{
    case FORM = 0
    case JSON
}

class GFKlineNetworkTools {
    //设置单例
    static let sharedInstance = GFKlineNetworkTools()
    private init() {}
    
}

var hostName:String{
    #if DEBUG
    return "https://liveapp.shmet.com/mapi"
    #else
    return "正式的域名"
    #endif
}
let header  = ["a":"b","c":"d", "e":"f"]  //设置请求头

typealias successCallBack = (_ jsonData:JSON) -> Void
typealias failureCallBack = (_ error:Error) -> Void

extension GFKlineNetworkTools {
    
  class  func request(type: MethodType,url:String,parameters:Parameters? = nil, successCallBack:@escaping  successCallBack,failureCallBack:@escaping failureCallBack){
        
        var encodingMethod:ParameterEncoding?
//        encodingMethod = JSONEncoding.default
      encodingMethod = URLEncoding.default
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(hostName + url, method: method, parameters: parameters, encoding: encodingMethod!, headers: nil).responseJSON { (responseObject) in
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
