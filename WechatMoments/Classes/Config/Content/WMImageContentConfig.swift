//
//  WMImageContentConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMImageContentConfig: WMCellContentConfigProtocol {
    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        let edges = contentInset(model: model)
        let imageWidth = width - edges.left - edges.right
        let height: CGFloat = 200
        
        return CGSize(width: imageWidth, height: height)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        return "\(WMTweetImageContentView.self)"
    }

}
