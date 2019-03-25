//
//  KlineDetailController.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire



class KlineDetailController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(titleModel: GFKlineAndTimeSharetitleModel())
    }
    
    func setupUI() -> Void {
        
        self.view.backgroundColor = UIColor.init(hex: "2A2D4F")
        GFKlineCaculateDataManager.sharedInstance().interfaceOrientation = .portrait;
        self.stockChartView.backgroundColor = UIColor.init(hex:"2A2D4F")
        self.stockChartView.interfaceOrientation = .portrait
        GFKlineCaculateDataManager.sharedInstance().GFKlineInfoViewHeight = 40
        self.view.addSubview(self.backButton)
        self.backButton.snp.makeConstraints { (make) in
            make.top.equalTo(UIDevice.current.statusBarHeight())
            make.left.equalTo(10)
            make.width.height.equalTo(40)
        }
    }
    
    //请求数据
    func loadData(titleModel:GFKlineAndTimeSharetitleModel) {
        
    }

    //返回Event
    @objc func backToRoot()->Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // --mark -- setter&& getter
    lazy var backButton = {()->UIButton in
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("back", for:UIControl.State.normal)
        btn.addTarget(self, action: #selector(backToRoot), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var stockChartView = {()->GFKlineChartBottomView in
        let chartView = GFKlineChartBottomView()
        self.view.addSubview(chartView)
        chartView.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view);
        })
        return chartView
    }()
    

}
