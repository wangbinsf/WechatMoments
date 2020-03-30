//
//  WMConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit
/// 计算高度的地方可以抽取出来

enum AvatarStyle {
    case normal
    case rounded
    case radiusCorner
}

enum ContentType {
    case singleImage
    case mutipleImage
    case text
    case text_image
    case unknowType
}

struct WMConfig {
    
    private init() {
        layoutConfig = WMCellLayoutConfig()
    }
    
    static var shared = WMConfig()
    
    var layoutConfig: WMCellLayoutConfigProtocol
    
    var avatarStyle: AvatarStyle?
    var nickFont: UIFont?
    var nickColor: UIColor?
    var textFont: UIFont?
    var textColor: UIColor?
    var multipleImageWH: CGFloat = 0
    let delayTime: TimeInterval = 3
    
    mutating func applyDefaultConfig() {
        avatarStyle = .radiusCorner
        nickFont = UIFont.boldSystemFont(ofSize: 18.0)
        nickColor = #colorLiteral(red: 0.3411764706, green: 0.4196078431, blue: 0.5803921569, alpha: 1)
        
        textFont = UIFont.systemFont(ofSize: 18.0)
        textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        multipleImageWH = 80
    }
}
