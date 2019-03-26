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
    var minNumber:Float = 0
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
    
    func dealWithArray(dataArray:Array<GFKlineModel>,isMarket:Bool) -> Array<GFKlineModel> {
        var modelArray:Array<GFKlineModel> = Array<GFKlineModel>()
        if isMarket {
            modelArray = caculateMarketMA(dataArray: dataArray)
            modelArray = caculateBOLL(modelArray: modelArray)
            modelArray = caculateKDJ(modelArray: modelArray)
            modelArray = caculateMACD(modelArray: modelArray)
        }else {
            
        }
        return modelArray
    }
    
    //计算MarketMA
    func caculateMarketMA(dataArray:Array<GFKlineModel>) -> Array<GFKlineModel> {
        var ma5:Float = 0
        var ma10:Float = 0
        var ma20:Float = 0
        var ma26:Float = 0
        var ma40:Float = 0
        var ma60:Float = 0
        
        var mul:Array<GFKlineModel> = Array<GFKlineModel>()
        var blankArray:Array<GFKlineModel> = Array<GFKlineModel>()
        self.minNumber = MAXFLOAT
        for  i in 0 ..< dataArray.count {
            var point:GFKlineModel = dataArray[i]
            let close = (point.close! as NSString)
            if  close.floatValue == 0{
                blankArray.append(point)
                continue
            }
            let lowest = (point.lowest! as NSString)
        
        if lowest.floatValue < self.minNumber {
        self.minNumber = lowest.floatValue
        }
        let closePrice:Float = close.floatValue
        ma5 += closePrice
        ma10 += closePrice
        ma20 += closePrice
        ma26 += closePrice
        ma40 += closePrice
        ma60 += closePrice
        if i >= 5 {
        let ma5model:GFKlineModel = dataArray[i - 5]
        ma5 -= (ma5model.close!as NSString).floatValue
        point.MA5 = NSNumber(value: ma5 / 5)
        } else {
        point.MA5 = NSNumber(value: ma5 / (Float)(i + 1) )
        }
        if i >= 10 {
        let ma10model:GFKlineModel = dataArray[i - 10]
        ma10 -= (ma10model.close!as NSString).floatValue
        point.MA10 = NSNumber(value: ma10 / 10)
        } else {
        point.MA10 = NSNumber(value: ma10 / (Float)(i + 1) )
        }
        if i >= 20 {
        let ma20model:GFKlineModel = dataArray[i - 20]
        ma20 -= (ma20model.close!as NSString).floatValue
        point.MA20 = NSNumber(value: ma20 / 20)
        } else {
        point.MA20 = NSNumber(value: ma20 / (Float)(i + 1) )
        }
        if i >= 26 {
        let ma26model:GFKlineModel = dataArray[i - 26]
        ma26 -= (ma26model.close!as NSString).floatValue
        point.MA26 = NSNumber(value: ma26 / 26)
        } else {
        point.MA26 = NSNumber(value: ma26 / (Float)(i + 1) )
        }
        
        if i >= 40 {
        let ma40model:GFKlineModel = dataArray[i - 40]
        ma40 -= (ma40model.close!as NSString).floatValue
        point.MA40 = NSNumber(value: ma40 / 40)
        } else {
        point.MA40 = NSNumber(value: ma40 / (Float)(i + 1) )
        }
        if i >= 60 {
        let ma60model:GFKlineModel = dataArray[i - 60]
        ma60 -= (ma60model.close!as NSString).floatValue
        point.MA60 = NSNumber(value: ma60 / 60)
        } else {
        point.MA60 = NSNumber(value: ma60 / (Float)(i + 1) )
        }
        mul.append(point)
        }
        return mul
    }
    //计算BOLL线
    func caculateBOLL(modelArray:Array<GFKlineModel>) -> Array<GFKlineModel> {
        var mul:Array<GFKlineModel> = Array<GFKlineModel>()
        for  i in 0 ..< modelArray.count {
            var model:GFKlineModel = modelArray[i]
            let closePrice:Float = (model.close! as NSString).floatValue
            if i == 0 {
                model.BOLL_MB = closePrice
                model.BOLL_UP = closePrice
                model.BOLL_DN = closePrice
                mul.append(model)
            }else {
                var n = 26
                if i < 26 {
                    n = i + 1
                }
                var md:Float = 0
                for  j in (i - n) ... i {
                    let M:GFKlineModel = modelArray[j]
                    let c:Float = (M.close! as NSString).floatValue
                    let m:Float = model.MA26!.floatValue
                    let value:Float = c - m
                    md += value * value
                    
                }
                md = md / (Float)(n-1)
                md = sqrtf(md)
                model.BOLL_MB = model.MA26!.floatValue
                model.BOLL_UP = model.BOLL_MB + 2*md
                model.BOLL_DN = model.BOLL_MB - 2*md
                mul.append(model)
            }
        }
        return mul
    }
    //就算KDJ
    func caculateKDJ(modelArray:Array<GFKlineModel>) -> Array<GFKlineModel> {
        var k:Float = 0
        var d:Float = 0
        var mul:Array<GFKlineModel> = Array<GFKlineModel>()
        for i in 0 ..< modelArray.count {
            var model:GFKlineModel = modelArray[i]
            let closePrice:Float = (model.close! as NSString).floatValue
            //kdj
            var startIndex:Int = i - 8
            if startIndex < 0 {
                startIndex = 0
            }
            var max9:Float = (model.highest! as NSString).floatValue
            var min9:Float = (model.lowest! as NSString).floatValue
            for index in startIndex ... i {
                let kmodel:GFKlineModel = modelArray[index]
                if (kmodel.highest! as NSString).floatValue > max9 {
                    max9 = (kmodel.highest! as NSString).floatValue
                }
                if (model.lowest! as NSString).floatValue < min9 {
                    min9 = (model.lowest! as NSString).floatValue
                }
            }
            var rsv:Float = 0
            if max9 == min9 {
                rsv = 0
            }else {
                rsv = 100 * (closePrice - min9) / (max9 - min9)
            }
            
            if (i == 0) {
                k = rsv
                d = rsv
            } else {
                k = (rsv + 2*k) / 3
                d = (k + 2*d) / 3
            }
            model.KDJ_K = NSNumber(value: k)
            model.KDJ_D = NSNumber(value: d)
            model.KDJ_J = NSNumber(value: (3*k - 2*d))
            mul.append(model)
        }
        return mul
    }
    //计算MACD
    func caculateMACD(modelArray:Array<GFKlineModel>) -> Array<GFKlineModel> {
        var ema12:Float = 0
        var ema26:Float = 0
        var dif:Float = 0
        var dea:Float = 0
        var macd:Float = 0
        var mul:Array<GFKlineModel> = Array<GFKlineModel>()
        for i in 0 ..< modelArray.count {
            var point:GFKlineModel = modelArray[i]
            let closePrice:Float = (point.close! as NSString).floatValue
            if (i == 0) {
                ema12 = closePrice
                ema26 = closePrice
            } else {
                ema12 = ema12 * 11 / 13 + closePrice * 2 / 13
                ema26 = ema26 * 25 / 27 + closePrice * 2 / 27
            }
            dif = ema12 - ema26
            dea = dea * 8 / 10 + dif * 2 / 10
            macd = (dif - dea) * 2
            point.DIF = dif
            point.DEA = dea
            point.MACD = macd
            mul.append(point)
        }
        return mul
    }

}
