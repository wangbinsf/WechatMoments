//
//  WMTextImageContentConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

class WMTextImageContentConfig: WMCellContentConfigProtocol {
    
    
    private let label = M80AttributedLabel()
    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        /// 计算文本size
        var height: CGFloat = 0
        let edges = contentInset(model: model)
        let labelWidth = width - edges.left - edges.right
        if let content = model.content {
            //            label.font = WMConfig.shared.textFont!
            label.text = content
            height = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)).height
        }
        /// 图片高度
        var imageHeight: CGFloat = 200
        if let images = model.images {
            if images.count >= 1 {
                let lines = (images.count - 1) / 3 + 1
                imageHeight = CGFloat(lines) * (WMConfig.shared.multipleImageWH + 10)
            }
        }
        return CGSize(width: labelWidth, height: height + imageHeight)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        return "\(WMTweetTextImageContentView.self)"
    }
    
}
