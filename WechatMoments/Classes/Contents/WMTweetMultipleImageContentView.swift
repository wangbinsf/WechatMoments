//
//  WMTweetMultipleImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetMultipleImageContentView: WMTweetContentView {
    /// 当前视图只绘制图片数量 > 1的情况
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {

    }
    
    /// 根据model显示图片
    ///
    override func refresh(data: WMTweetModel) {
        super.refresh(data: data)
        guard let images = data.images, images.count > 0 else {
            assert(false, "请提前处理非法图片数据")
            return
        }
        if images.count >= 1 {
            showMultipleImages(images.map { $0.url })
        }
        setNeedsLayout()
    }
    var imageViews: [UIImageView] = []
    
    /// 多张图片
    func showMultipleImages(_ images: [String]) {
//        for subview in imageViews {
//            subview.removeFromSuperview()
//        }
//        imageViews.removeAll()
//        subviews.forEach { $0.removeFromSuperview() }
        
        var leading: CGFloat = 0
        var top: CGFloat = 0
        let imageMargin: CGFloat = 5
        let imageViewWH: CGFloat = WMConfig.shared.multipleImageWH
        
        for (index, imgName) in images.enumerated() {
            let imageView = UIImageView()
            imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            addSubview(imageView)
            leading = CGFloat(index % 3) * (imageViewWH + imageMargin)
            top = CGFloat(index / 3) * (imageViewWH + imageMargin)
            imageViews.append(imageView)
            imageView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().offset(leading)
                make.top.equalToSuperview().offset(top)
                make.width.equalTo(imageViewWH)
                make.height.equalTo(imageViewWH)
            }
            imageView.sd_setImage(with: URL(string: imgName)!)
        }
    }
}
