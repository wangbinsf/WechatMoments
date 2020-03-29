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
    
    /// 返回内容inset
    func contentInset(model: WMTweetModel) -> UIEdgeInsets
    
    /// 需要的构造cellContent的类名
    func cellClass(model: WMTweetModel) -> String
    
    /// 评论的高度
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize
}

extension WMCellContentConfigProtocol {
    
    /// 返回内容inset
    func contentInset(model: WMTweetModel) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 74, bottom: 40, right: 20)
    }
    
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        var height: CGFloat = 0
        if let comments = model.comments {
            let count = comments.count
            /// 这里需要根据文字计算高度
            height = CGFloat(count * 30)
        }
        return CGSize(width: 320, height: height)
    }
    
}


class WMCellContentConfigFactory {
    
    private init() {
        dict = [
            ContentType.text: WMTextContentConfig(),
            ContentType.singleImage: WMImageContentConfig(),
            ContentType.text_image: WMTextImageContentConfig(),
            ContentType.mutipleImage: WMMultipleImageContentConfig()
        ]
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
