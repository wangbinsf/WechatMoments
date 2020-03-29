//
//  WMTweetTextImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetTextImageContentView: WMTweetContentView {
    
    let textContent = WMTweetTextContentView()
    var imageContent: WMTweetContentView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTextContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTextContent()
    }
    
    func addTextContent() {
        /// 显示文本
        addSubview(textContent)
        textContent.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setImageContent() {
        /// 显示图片
        addSubview(imageContent)
        imageContent.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(textContent.snp_bottom)
        }
    }
    
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        
        guard let images = data.images, images.count > 0 else {
            assert(false)
            return
        }
        
        if imageContent != nil {
            imageContent.removeFromSuperview()
        }
        
        if images.count == 1 {
            imageContent = WMTweetImageContentView()
        } else if images.count > 1 {
            imageContent = WMTweetMultipleImageContentView()
        }
        setImageContent()
        textContent.refresh(data: data)
        imageContent.refresh(data: data)
    }
}
