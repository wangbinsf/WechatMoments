//
//  WMCellLayoutConfig.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit
import M80AttributedLabel

protocol WMCellLayoutConfigProtocol {
    
    var contentWidth: CGFloat { get }
    
    /// 返回内容大小
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize
    
    /// 返回内容inset
    func contentInset(model: WMTweetModel) -> UIEdgeInsets

    /// 需要的构造cellContent的类名
    func cellClass(model: WMTweetModel) -> String
    
    /// 评论的高度
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize
    
}
