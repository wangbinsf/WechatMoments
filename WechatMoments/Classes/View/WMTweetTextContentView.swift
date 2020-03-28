//
//  WMTweetTextContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetTextContentView: WMTweetContentView {
    
    lazy var textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        
        textLabel.text = "这是测试数据"
        addSubview(textLabel)
    }
    
    override func refresh(data: WMTweetModel) {
//        textLabel.text = data.content
    }

}
