//
//  WMCellContentConfigProtocol.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

protocol WMCellContentConfigProtocol {
    /// 返回内容大小
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize
    
    /// 返回内容origin
    func contentOrigin(model: WMTweetModel) -> CGPoint
    
    /// 需要的构造cellContent的类名
    func cellClass(model: WMTweetModel) -> String
}
