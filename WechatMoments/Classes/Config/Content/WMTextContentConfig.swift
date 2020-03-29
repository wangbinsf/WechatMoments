//
//  WMTextContentConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

class WMTextContentConfig: WMCellContentConfigProtocol {
    

    
    private let label = M80AttributedLabel()
    

    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        /// 计算文本size
        var height: CGFloat = 0
        let edges = contentInset(model: model)
        let labelWidth = width - edges.left - edges.right
        if let content = model.content {
            label.text = content
            height = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        return CGSize(width: labelWidth, height: height)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        return "WMTweetTextContentView"
    }
    

}
