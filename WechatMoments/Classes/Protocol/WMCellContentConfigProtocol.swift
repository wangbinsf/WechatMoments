//
//  WMCellContentConfigProtocol.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit
import M80AttributedLabel

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
        let inset = contentInset(model: model)
        let inWidth = width - inset.left - inset.right
        if let comments = model.comments {
            /// 这里需要根据文字计算高度
            height = calculateTotalHeightOfCommentView(comments, width: inWidth)
        }
        
        return CGSize(width: inWidth, height: height)
    }
        
    func calculateTotalHeightOfCommentView(_ comments: [WMTweetModel.Comment], width: CGFloat) -> CGFloat {
        var totalHeight: CGFloat = 0
        for comment in comments {
            let height = heightOfComment(comment, width: width)
            totalHeight += height
        }
        return totalHeight
    }
    
    func heightOfComment(_ comment: WMTweetModel.Comment, width: CGFloat) -> CGFloat {
        let lablel = M80AttributedLabel()
        lablel.text = comment.content
        let height = lablel.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
        return height
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
