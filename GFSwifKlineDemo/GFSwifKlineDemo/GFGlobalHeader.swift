//
//  GFGlobalHeader.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
let defaults = UserDefaults.standard
//屏幕的宽高
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
// 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }


extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height >= 812 {
            return true
        }
        return false
    }
    
    public func navigationBarHeight() -> CGFloat {
        if UIDevice.current.isX() {
            return 88;
        }else {
            return 64;
        }
    }
    
    public func statusBarHeight() -> CGFloat {
        if UIDevice.current.isX() {
            return 44;
        }else {
            return 20;
        }
    }
    
    public func bottomSafeHeight() -> CGFloat {
        if UIDevice.current.isX() {
            return 34;
        }else {
            return 0;
        }
    }
    
}

