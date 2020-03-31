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
    
    /// 返回内容大小
    func contentSize(model: WMTweetModel, width: CGFloat) -> CGSize
    
    /// 返回内容inset
    func contentInset(model: WMTweetModel) -> UIEdgeInsets

    /// 需要的构造cellContent的类名
    func cellClass(model: WMTweetModel) -> String
    
    /// 评论的高度
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize
    
}

extension WMCellLayoutConfigProtocol {
    func commentsSize(model: WMTweetModel, width: CGFloat) -> CGSize {
        var height: CGFloat = 0
        if let comments = model.comments {
//            let count = comments.count
            /// 这里需要根据文字计算高度
            height = calculateTotalHeightOfCommentView(comments)
        }
        return CGSize(width: 320, height: height)
    }
    
    func calculateTotalHeightOfCommentView(_ comments: [WMTweetModel.Comment]) -> CGFloat {
        var totalHeight: CGFloat = 0
        for comment in comments {
            let height = heightOfComment(comment)
            totalHeight += height
        }
        return totalHeight
    }
    
    func heightOfComment(_ comment: WMTweetModel.Comment) -> CGFloat {
        let lablel = M80AttributedLabel()
        lablel.text = comment.content
        let height = lablel.sizeThatFits(CGSize(width: 320, height: CGFloat.greatestFiniteMagnitude)).height
        return height
    }
}
