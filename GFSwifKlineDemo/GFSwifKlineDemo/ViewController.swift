//
//  ViewController.swift
//  GFSwifKlineDemo
//
//  Created by winterJiao on 2019/3/25.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupUI() -> Void {
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(self.centerButton)
        self.centerButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(100)
        }
    }
    
    //k线详情 touchUpinSide
   @objc func klineDetail() -> Void {
        self.present(KlineDetailController(), animated: true, completion: nil)
    }
    
   // #mark $setter&&getter
    lazy var centerButton = {()->UIButton in
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("klineDetail", for:UIControl.State.normal)
        btn.addTarget(self, action: #selector(klineDetail), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    
    
}

