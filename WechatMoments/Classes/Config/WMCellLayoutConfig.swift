//
//  WMCellLayoutConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMCellLayoutConfig: WMCellLayoutConfigProtocol {
    
    var contentWidth = CGFloat(Constants.screenWidth - 94)
    
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        return WMCellContentConfigFactory.shared.configBy(model: model).commentsSize(model: model, width: width)
    }
    
    
    func contentInset(model: WMTweetModel) -> UIEdgeInsets {
        return WMCellContentConfigFactory.shared.configBy(model: model).contentInset(model: model)
    }
    
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        return WMCellContentConfigFactory.shared.configBy(model: model).contentSize(model: model, width: width)
    }
    
    func cellClass(model: WMTweetModel) -> String {
        let factory = WMCellContentConfigFactory.shared
        let config = factory.configBy(model: model)
        return config.cellClass(model: model)
    }
    
}



