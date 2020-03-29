//
//  WMTweetTextContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

class WMTweetTextContentView: WMTweetContentView {
    
    lazy var textLabel = M80AttributedLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        addSubview(textLabel)
        
        
    }
    
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        textLabel.text = data.content
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        /// 计算文本size
//        var height: CGFloat = 0
//
//        let edges = contentInset(model: model)
//        let labelWidth = width - edges.left - edges.right
//        if let content = model.content {
//            label.text = content
//            height = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)).height
//        }
    }

}
