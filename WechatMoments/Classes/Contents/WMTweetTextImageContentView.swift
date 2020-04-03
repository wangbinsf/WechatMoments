//
//  WMTweetTextImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import M80AttributedLabel

class WMTweetTextImageContentView: WMTweetContentView {
    
    var textContent: WMTweetTextContentView?
    var imageContent: WMTweetContentView?
    var imageHeight: CGFloat = 0
    
    private let label = M80AttributedLabel()
    
    func addContent() {
        label.text = tweet!.content!
        let height = label.sizeThatFits(CGSize(width: Constants.screenWidth - 94, height: CGFloat.greatestFiniteMagnitude))
        addSubview(textContent!)
        textContent!.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        /// 显示图片
        addSubview(imageContent!)
        
        imageContent!.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(textContent!.snp.bottom)
            make.height.equalTo(imageHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        guard let images = data.images, images.count > 0 else {
            assert(false)
            return
        }
        
        if imageContent != nil {
            imageContent?.removeFromSuperview()
        }
        if textContent != nil {
            textContent?.removeFromSuperview()
        }
        
        textContent = WMTweetTextContentView()
        if images.count == 1 {
            imageContent = WMTweetImageContentView()
            imageHeight = 200
        } else if images.count > 1 {
            imageContent = WMTweetMultipleImageContentView()
            let config = WMMultipleImageContentConfig()
            let size = config.contentSize(model: data, width: Constants.screenWidth)
            imageHeight = size.height
        }
        addContent()
        textContent!.refresh(data: data)
        imageContent!.refresh(data: data)
    }
    
}
