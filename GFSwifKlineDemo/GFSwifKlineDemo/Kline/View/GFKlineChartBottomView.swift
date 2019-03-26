//
//  GFKlineChartBottomView.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SnapKit

class GFKlineChartBottomView: UIView,UIScrollViewDelegate {
    var interfaceOrientation:UIInterfaceOrientation?
    var oldExactOffset:CGFloat = 0
    var kLineMainViewHeightConstraint:Constraint?
    var kLineVolumeViewHeightConstraint:Constraint?
    var CJLViewTapType:NSInteger = 0
    var mainViewType:NSInteger = 1
    var kLineModels:Array<GFKlineModel> = Array<GFKlineModel>()
    override init(frame: CGRect) {
        //子类初始化的一些操作需要放到super.init之前
        super.init(frame: frame)
        GFKlineCaculateDataManager.sharedInstance().GFKlineMainViewRadio = 0.65
        GFKlineCaculateDataManager.sharedInstance().GFKlineVolumeViewRadio = 0.35
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func setKlineModelsArray(klineModels:Array<GFKlineModel>) -> Void {
        self.kLineModels = klineModels
        
    }
    
    func setupUI() -> Void {
    self.addSubview(self.scrollView)
    self.scrollView.snp.makeConstraints { (make) in
        make.top.right.left.bottom.equalTo(self);
    }
    self.scrollView.addSubview(self.kLineMainView)
    self.kLineMainView.snp.makeConstraints { (make) in
        make.top.equalTo(self.scrollView).offset(0);
        make.left.equalTo(self.scrollView).offset(0);
    make.height.equalTo(self.scrollView).multipliedBy(GFKlineCaculateDataManager.sharedInstance().GFKlineMainViewRadio);
    }
    self.scrollView.addSubview(self.kLineVolumeView)
        self.kLineVolumeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.snp.bottom);
            make.width.equalTo(self.kLineMainView.snp.width);
        make.height.equalTo(self.scrollView).multipliedBy(GFKlineCaculateDataManager.sharedInstance().GFKlineVolumeViewRadio);
        }
        self.addSubview(self.kLineInfoView)
        self.kLineInfoView.snp.makeConstraints { (make) in
            make.right.top.equalTo(self);
            make.left.equalTo(self);
            make.height.equalTo(40);
        }
        self.addSubview(self.accessInfoView)
        self.accessInfoView.snp.makeConstraints { (make) in
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.snp.top);
            make.height.equalTo(20);
        }
        self.addSubview(self.clearView)
        self.clearView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self);
        }
        self.insertSubview(self.dateView, aboveSubview: self.scrollView)
        self.dateView.snp.makeConstraints { (make) in
            make.height.equalTo(20);
            make.right.left.bottom.equalTo(self);
        }
        self.insertSubview(self.leftPriceView, aboveSubview: self.scrollView)
        self.leftPriceView.snp.makeConstraints { (make) in
            make.width.equalTo(100);
            make.left.equalTo(self);
            make.bottom.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineInfoView.snp.bottom);
        }
        self.insertSubview(self.volumeLeftView, aboveSubview: self.scrollView)
        self.volumeLeftView.snp.makeConstraints { (make) in
            make.width.equalTo(100);
            make.left.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
            make.top.equalTo(self.accessInfoView.snp.bottom);
        }
        self.insertSubview(self.volumeRightView, aboveSubview: self.scrollView)
        self.volumeRightView.snp.makeConstraints { (make) in
            make.width.equalTo(100);
            make.right.equalTo(self).offset(-8);
            make.bottom.equalTo(self).offset(-20);
            make.top.equalTo(self.accessInfoView.snp.bottom);
        }
        self.insertSubview(self.kLineMainGridlineView, aboveSubview: self.scrollView)
        self.kLineMainGridlineView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.kLineMainView);
            make.left.right.equalTo(self);
        }
        self.insertSubview(self.kLineVolumeGridlinesView, aboveSubview: self.scrollView)
        self.kLineVolumeGridlinesView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.kLineVolumeView);
            make.left.right.equalTo(self);
        }
        
    }
    
    
    //#mark-- setter&&getter
    lazy var scrollView = {()->UIScrollView in
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.delegate = self
        scrollView.bounces = false
        var pinchGesture:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(event_pichMethod(pinch:)))
        scrollView.addGestureRecognizer(pinchGesture)
        var longPress:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(event_longPressMethod(longPress:)))
        scrollView.addGestureRecognizer(longPress)
        return scrollView
    }()

    
    lazy var kLineMainView = {()->GFKlineMainKlineView in
        let mainView = GFKlineMainKlineView()
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(topViewClick(tap:)))
        mainView.addGestureRecognizer(tap)
        return mainView
    }()

    lazy var kLineVolumeView = {()->GFKlineAccessView in
        let accessView = GFKlineAccessView()
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bottomViewClick(tap:)))
        accessView.addGestureRecognizer(tap)
        return accessView
    }()
    
    lazy var kLineMainGridlineView = {()->GFKlineMainGridlinesView in
        let gridlineView = GFKlineMainGridlinesView()
        gridlineView.isUserInteractionEnabled = false
        return gridlineView
    }()
    
    lazy var kLineVolumeGridlinesView = {()->GFKlineAccessGridlinesView in
        let gridlineView = GFKlineAccessGridlinesView()
        gridlineView.isUserInteractionEnabled = false
        return gridlineView
    }()
    
    lazy var kLineInfoView = {()->GFKlineMainInfoView in
        let mainInfoView = GFKlineMainInfoView()
        return mainInfoView
    }()
    
    lazy var accessInfoView = {()->GFKlineAccessInfoView in
        let accInfoView = GFKlineAccessInfoView()
        return accInfoView
    }()
    
    lazy var clearView = {()->GFKlineLongPressBottomView in
        let celarView = GFKlineLongPressBottomView()
        return celarView
    }()
    
    lazy var leftPriceView = {()->GFKlineMainLeftDataView in
        let leftPrice = GFKlineMainLeftDataView()
        return leftPrice
    }()
    
    lazy var volumeLeftView = {()->GFKlineAccessLeftDataView in
        let acleftView = GFKlineAccessLeftDataView()
        return acleftView
    }()
    
    lazy var volumeRightView = {()->GFKlineAccessRightDataView in
        let acrightView = GFKlineAccessRightDataView()
        return acrightView
    }()
    
    lazy var dateView = {()->GFKlineDateView in
        let dView = GFKlineDateView .sharedInstance()
        return dView
    }()
    
    lazy var leftAndRightView = {()->GFKlineTabDataView in
        let leftAndRight = GFKlineTabDataView()
        return leftAndRight
    }()
    
    //#mark-- GestureRecognizer Event
    
    @objc func event_pichMethod(pinch:UIPinchGestureRecognizer) -> Void {
        
    }
    
    @objc func event_longPressMethod(longPress:UILongPressGestureRecognizer) -> Void {
        
    }
    
    @objc func topViewClick(tap:UITapGestureRecognizer) -> Void {
        
    }
    
    @objc func bottomViewClick(tap:UITapGestureRecognizer) -> Void {
        
    }
    
}

extension GFKlineMainKlineView:UIScrollViewDelegate {
    
}
