//
//  WMCommentsView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

class WMCommentsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func refreshData(comments: [WMTweetModel.Comment]) {
        var lastCommentView: UIView?
        for (index, comment) in comments.enumerated() {
            let singleView = singleCommentView(comment)
            addSubview(singleView)
            
            singleView.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                /// top
                if lastCommentView == nil {
                    make.top.equalToSuperview()
                } else {
                    make.top.equalTo(lastCommentView!.snp.bottom)
                }
                /// bottom
                if index == comments.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            lastCommentView = singleView
        }
    }
    
    /// 单条评论的视图
    func singleCommentView(_ comment: WMTweetModel.Comment) -> UIView {
        let singView = UIView()
        let textLabel = M80AttributedLabel()
        textLabel.underLineForLink = false
        textLabel.autoDetectLinks = false
        let senderNick = comment.sender.nick
        let text = senderNick + ": " + comment.content
        textLabel.text = text
        let range = NSRange(location: 0, length: senderNick.count)
        textLabel.delegate = self
        textLabel.addCustomLink(comment, for: range, linkColor: WMConfig.shared.nickColor!)
        
        singView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(heightOfComment(comment))
        }
        return singView
    }
    
    func heightOfComment(_ comment: WMTweetModel.Comment) -> CGFloat {
        let lablel = M80AttributedLabel()
        lablel.text = comment.content
        let height = lablel.sizeThatFits(CGSize(width: 320, height: CGFloat.greatestFiniteMagnitude)).height
        return height
    }
}

extension WMCommentsView: M80AttributedLabelDelegate {
    
    func m80AttributedLabel(_ label: M80AttributedLabel, clickedOnLink linkData: Any) {
        guard let comment = linkData as? WMTweetModel.Comment else {
            return
        }
        print(comment.sender)
    }

}
