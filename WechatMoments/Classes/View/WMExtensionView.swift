//
//  WMExtensionView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/1.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

/// 发布地点及发布时间
class WMExtensionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let locationView = M80AttributedLabel()
        locationView.text = "北京"
        addSubview(locationView)
        locationView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        let timeView = M80AttributedLabel()
        timeView.text = "1小时前"
        addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(locationView.snp.bottom)
            make.height.equalTo(25)
        }
    }
    
}
