//
//  GFKlineModel.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/26.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct GFKlineModel {
    var lowest:String?
    var source:String?
    var contract: String?
    var preClose: String?
    var chgInterest: String?
    var close: String?
    var updown: String?
    var volume: String?
    var interest: String?
    var ruleAt: Int64?
    var settle: String?
    var last: String?
    var highest: String?
    var chgVolume: String?
    var preInterest: String?
    var open: String?
    var percent: String?
    var average: String?
    var isLowest: Bool?
    var isHighest: Bool?
    var isBlank: Bool?
    var maxWidth: CGFloat = 0
    var MA5: NSNumber?
    var MA10: NSNumber?
    var MA20: NSNumber?
    var MA40: NSNumber?
    var MA60: NSNumber?
    var MA26: NSNumber?
    var KDJ_K: NSNumber?
    var KDJ_D: NSNumber?
    var KDJ_J: NSNumber?
    var BOLL_MD: Float = 0
    var BOLL_MB: Float = 0
    var BOLL_UP: Float = 0
    var BOLL_DN: Float = 0
    var DIF: Float = 0
    var DEA: Float = 0
    var MACD: Float = 0
    //    var PreviousKlineModel:GFKlineModel?

    init(jsonData: JSON) {
        source = jsonData["source"].stringValue
        lowest = jsonData["lowest"].stringValue
        contract = jsonData["contract"].stringValue
        preClose = jsonData["preClose"].stringValue
        chgInterest = jsonData["chgInterest"].stringValue
        close = jsonData["close"].stringValue
        updown = jsonData["updown"].stringValue
        volume = jsonData["volume"].stringValue
        interest = jsonData["interest"].stringValue
        ruleAt = jsonData["ruleAt"].int64
        settle = jsonData["settle"].stringValue
        last = jsonData["last"].stringValue
        highest = jsonData["highest"].stringValue
        chgVolume = jsonData["chgVolume"].stringValue
        preInterest = jsonData["preInterest"].stringValue
        open = jsonData["open"].stringValue
        percent = jsonData["percent"].stringValue
//        isLowest = jsonData["isLowest"].boolValue
//        isHighest = jsonData["isHighest"].boolValue
//        isBlank = jsonData["isBlank"].boolValue
        
        
    }
    
 }
