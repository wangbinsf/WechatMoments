//
//  WMCellLayoutConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMCellLayoutConfig: WMCellLayoutConfigProtocol {
    
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

class WMCellContentConfigFactory {
    private init() {
        dict = [ContentType.text: WMTextContentConfig()]
    }
    private var dict: [ContentType: WMCellContentConfigProtocol] = [:]
    static let shared = WMCellContentConfigFactory()
    
    func configBy(model: WMTweetModel) -> WMCellContentConfigProtocol {
        let type = model.contentType
        let config = dict[type]
        /// 待完善
        if config == nil {
            assert(false)
        }
        return config!
    }
}


