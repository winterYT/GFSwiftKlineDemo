//
//  UILabelFixedWidthAndHeightExtension.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UILabelFixedWidthAndHeightExtension: NSObject {

}

extension UILabel {
    // MARK:固定宽度或者高度，求得UILabel的所需要的高度或者宽度，返回结果再 + 5个单位使其不拥挤
    func sizeToFitWithWidth(width:Double) -> CGFloat {
        let size = CGSize.init(width: width, height: 10000)
        let targetSize:CGRect = self.text!.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil)
        return targetSize.height+5
    }
    
    func sizeToFitHeight(height:Double) -> CGFloat {
        let size = CGSize.init(width: 10000, height: height)
        let targetSize:CGRect = self.text!.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil)
        return targetSize.width+5
    }
}
