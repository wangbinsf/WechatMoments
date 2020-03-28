//
//  WMTextContentConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTextContentConfig: WMCellContentConfigProtocol {
    func contentOrigin(model: WMTweetModel) -> CGPoint {
        return CGPoint(x: 60, y: 50)
    }
    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        return "WMTweetTextContentView"
    }
    

}
