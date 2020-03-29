//
//  WMTweetContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetContentView: UIView {
    
    var tweet: WMTweetModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func refresh(data: WMTweetModel) {
        self.tweet = data
    }

}
