//
//  GFKlineDateView.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/26.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class GFKlineDateView: UIView {
    static let instance: GFKlineDateView = GFKlineDateView()
    class func sharedInstance() -> GFKlineDateView {
        return instance
    }
}
