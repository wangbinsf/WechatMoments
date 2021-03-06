//
//  WMTweetImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import SnapKit
//import SDWebImage

class WMTweetImageContentView: WMTweetContentView {
    
    lazy var singleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        clipsToBounds = true
        singleImageView.contentMode = .scaleAspectFill
        singleImageView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        addSubview(singleImageView)
        singleImageView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 200))
        }
    }
    
    /// 根据model显示图片
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        guard let images = data.images, images.count > 0 else {
            assert(false, "请提前处理非法图片数据")
            return
        }
        if images.count == 1 {
            showSingleImage()
        }
    }
    
    /// 处理一张图片的情形
    func showSingleImage() {
        guard let tweet = tweet, let image = tweet.images?.first, let url = URL(string: image.url) else { return }
        singleImageView.wm_setImage(with: url)
    }

}
