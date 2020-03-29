//
//  WMTweetImageContentView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
class WMTweetImageContentView: WMTweetContentView {
    
    /// 当前视图只绘制图片数量 > 0的情况
    
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
        singleImageView.contentMode = .scaleAspectFit
        addSubview(singleImageView)
        singleImageView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 200))
        }
    }
    
    /// 根据model显示图片
    ///
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
        SDWebImageManager.shared().imageDownloader?.downloadTimeout = 200
        singleImageView.sd_setImage(with: url, placeholderImage: nil, options: .lowPriority, progress: { (a, b, url) in
            print(a, b)
        }) { (image, error, cache, url) in
            /// 下载完成，计算显示布局
            guard let image = image else { return }
            let scale = image.size.width / image.size.height
            let maxHeight: CGFloat = 200
            let maxWidth = maxHeight * scale
            self.singleImageView.snp.updateConstraints { (make) in
                make.size.equalTo(CGSize(width: maxWidth, height: maxHeight))
            }
        }

    }

}
