//
//  GFKlineCaculateDataManager.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class GFKlineCaculateDataManager: NSObject {
    static let instance: GFKlineCaculateDataManager = GFKlineCaculateDataManager()
    class func sharedInstance() -> GFKlineCaculateDataManager {
        return instance
    }
    var interfaceOrientation:UIInterfaceOrientation?
    var GFKlineCandleWidth:CGFloat = 0
    var GFKlineMaxScrollViewHeight:CGFloat = 0
    var GFKlineKlineGap:CGFloat = 0
    var GFKlineTimeShareGap:CGFloat = 0
    var GFKlineMainViewRadio:CGFloat = 0
    var GFKlineVolumeViewRadio:CGFloat = 0
    var GFKlineTimeShareKlineWidth:CGFloat = 0
    var GFKlineInfoViewHeight:CGFloat = 0
    
    override init() {
        self.GFKlineCandleWidth = 5
        self.GFKlineKlineGap = 0.5
        self.GFKlineTimeShareGap = 0.5
        self.GFKlineInfoViewHeight = 40
        self.GFKlineMainViewRadio = 0.65
        self.GFKlineVolumeViewRadio = 0.35
        self.GFKlineTimeShareKlineWidth = 5
    }

}
