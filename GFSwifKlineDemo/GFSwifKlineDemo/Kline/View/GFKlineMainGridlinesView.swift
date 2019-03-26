//
//  GFKlineMainGridlinesView.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/26.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class GFKlineMainGridlinesView: UIView {
    var isLandScape:Bool = false
    var superHeight:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLogoView()
        setupGridlineFunction()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupGridlineFunction() -> Void {
        let minHeight:CGFloat = GFKlineCaculateDataManager.sharedInstance().GFKlineInfoViewHeight
        if self.isLandScape == false {
            for  line:UIView in self.lineArray {
                line.removeFromSuperview()
            }
            //绘制网格线 横线
            let selfHeight:CGFloat = self.superHeight * GFKlineCaculateDataManager.sharedInstance().GFKlineMainViewRadio
            let verticalSpace:CGFloat = (selfHeight - minHeight) / 5
            let horizontalSpace:CGFloat = (CGFloat)((SCREEN_MIN - 26*2) / 5)
            
            for  i in 0 ..< 6  {
                let horizontalGridLine:UIView = UIView()
                horizontalGridLine.backgroundColor = UIColor(hex:"ffffff")
                horizontalGridLine.alpha = 0.05
                self.addSubview(horizontalGridLine)
                if i == 5 {
                    horizontalGridLine.frame = CGRect(x:0, y: selfHeight - 1, width: SCREEN_MIN, height: 1)
    
                }else {
                    horizontalGridLine.frame = CGRect(x:0, y:(verticalSpace * (CGFloat)(i) + minHeight), width: SCREEN_MIN, height:1)
                }
                self.lineArray.append(horizontalGridLine)
            }
            //竖线
            for i in 0 ..< 6 {
                let verticalGridLine:UIView = UIView(frame: CGRect(x: 26 + (horizontalSpace)*(CGFloat)(i), y: minHeight, width: 1, height: selfHeight - minHeight))
                verticalGridLine.backgroundColor = UIColor(hex:"ffffff")
                verticalGridLine.alpha = 0.05
                self.addSubview(verticalGridLine)
                self.lineArray.append(verticalGridLine)
               
            }
        }else {
//            for (UIView*line in self.lineArray) {
//                [line removeFromSuperview];
//            }
//            //绘制网格线 横线
//            CGCGFloat selfHeight = self.supeprHeight *[GJKlineConfigParameters kLineMainViewRadio];
//            CGCGFloat verticalSpace = (selfHeight - 20) / 5;
//            CGCGFloat horizontalSpace = 0;
//            CGCGFloat lineWidth = 0;
//            if (ISIPHONE_X) {
//                horizontalSpace = (SCREEN_MAX - 26*2  - 140 - STATUSBAR_HEIGHT)/5;
//                lineWidth = SCREEN_MAX  - 140 - STATUSBAR_HEIGHT;
//
//            }else {
//                horizontalSpace = (SCREEN_MAX - 26*2  - 140)/5;
//                lineWidth = SCREEN_MAX  - 140 ;
//            }
//
//            for (NSInteger i = 0; i < 6; i ++) {
//                UIView *horizontalGridLine = [UIView new];
//                horizontalGridLine.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:0.05];
//                [self addSubview:horizontalGridLine];
//                if (i == 5) {
//                    horizontalGridLine.frame =  CGRectMake(0,selfHeight -1, lineWidth, 1);
//
//                }else {
//                    horizontalGridLine.frame =  CGRectMake(0,(verticalSpace)*i + 20, lineWidth, 1);
//
//                }
//                [self.lineArray addObject:horizontalGridLine];
//            }
//            //竖线
//            for (NSInteger i = 0; i < 7; i ++) {
//                UIView *verticalGridLine = [[UIView alloc] initWithFrame:CGRectMake(26+(horizontalSpace)*i,0,1,selfHeight)];
//                if (i == 6) {
//                    verticalGridLine.frame = CGRectMake(26+(horizontalSpace)*5 + 26,0,1,selfHeight);
//                }
//                verticalGridLine.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:0.05];
//                [self addSubview:verticalGridLine];
//                [self.lineArray addObject:verticalGridLine];
//            }
        }
    }
    
    func setupLogoView() -> Void {
        let logoImageV:UIImageView = UIImageView()
        logoImageV.image = UIImage(named: "ic_chart_logo")
        self.addSubview(logoImageV)
        logoImageV.snp.makeConstraints { (make) in
            make.center.equalTo(self);
        }
    }
    lazy var lineArray:Array<UIView> = {()->Array<UIView> in
        let array = Array<UIView>()
        return array
    }()
    
    
    


}
