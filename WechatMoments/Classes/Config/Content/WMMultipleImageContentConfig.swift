//
//  WMMultipleImageContentConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMMultipleImageContentConfig: WMCellContentConfigProtocol {
    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        let edges = contentInset(model: model)
        let contentWidth = width - edges.left - edges.right
        var height: CGFloat = 80
        if let images = model.images {
            guard images.count > 1 else {
                assert(false, "图片不存在")
                return CGSize.zero
            }
            let lines = (images.count - 1) / 3 + 1
            height = CGFloat(lines) * (WMConfig.shared.multipleImageWH + 10)
        }
        return CGSize(width: contentWidth, height: height)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        return "\(WMTweetMultipleImageContentView.self)"
    }
}
