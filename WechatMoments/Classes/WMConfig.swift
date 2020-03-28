//
//  WMConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

enum AvatarStyle {
    case normal
    case rounded
    case radiusCorner
}

enum ContentType {
    case image
    case text
    case text_image
    case unknowType
}

struct WMConfig {
    
    private init() {
        layoutConfig = WMCellLayoutConfig()
    }
    
    static let shared = WMConfig()
    
    var layoutConfig: WMCellLayoutConfigProtocol
    
    var avatarStyle: AvatarStyle?
    var nickFont: UIFont?
    var nickColor: UIColor?
    
    private mutating func defaultConfig() {
        avatarStyle = .normal
        nickFont = UIFont.systemFont(ofSize: 15.0)
        nickColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
}
