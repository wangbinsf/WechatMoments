//
//  ImageLoader.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/2.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

/// 处理图片内存及磁盘的读取操作

class ImageCacheLoader {
    
    /// 获取图片
    func loadImage(with url: URL, completionHandle: @escaping (UIImage?) -> Void) {
        if let image = ImageCache.shared.image(for: url) {
            /// 1、在内存中查找
            completionHandle(image)
        } else {
            /// 2、如果内存不存在，在磁盘查找
            let image = ImageCache.shared.retrieveImage(forKey: url)
            completionHandle(image)
            ImageCache.shared.setImage(image, for: url)
        }
    }
    
    /// 保存图片
    func saveImage(_ image: UIImage, for url: URL, completed: (() -> Void)? = nil) {
        /// 存储到内存
        ImageCache.shared.setImage(image, for: url)
        /// 存储到磁盘
        ImageCache.shared.store(image: image, forKey: url, completed: completed)
    }
 
    
}
