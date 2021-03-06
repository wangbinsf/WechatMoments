//
//  WMTweetMultipleImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetMultipleImageContentView: WMTweetContentView {

    /// 根据model显示图片
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        guard let images = data.images, images.count > 0 else {
            assert(false, "请提前处理非法图片数据")
            return
        }
        if images.count >= 1 {
            showMultipleImages(images.map { $0.url })
        }
    }
    
    /// 多张图片
    func showMultipleImages(_ images: [String]) {
        
        var leading: CGFloat = 0
        var top: CGFloat = 0
        let imageMargin: CGFloat = 5
        let imageViewWH: CGFloat = WMConfig.shared.multipleImageWH
        
        for (index, imgName) in images.enumerated() {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
            addSubview(imageView)
            leading = CGFloat(index % 3) * (imageViewWH + imageMargin)
            top = CGFloat(index / 3) * (imageViewWH + imageMargin)
            imageView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(leading)
                make.top.equalToSuperview().offset(top)
                make.width.equalTo(imageViewWH)
                make.height.equalTo(imageViewWH)
            }
            imageView.wm_setImage(with: URL(string: imgName)!)
        }
    }
}
