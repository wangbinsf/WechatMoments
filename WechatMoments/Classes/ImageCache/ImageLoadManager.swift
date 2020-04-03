//
//  ImageLoadManager.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/2.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

/// 图片从网络获取到显示在屏幕上，主要经过以下三步
/// 1、加载经压缩的数据到内存
/// 2、从内存读取压缩数据，把图片从PNG或JPEG等格式中解压出来，得到像素数据
/// 3、CPU、GPU合作渲染图片到屏幕


class ImageLoadManager {
    
    private init() {}
    static let shared = ImageLoadManager()
    
    private let cacheLoader = ImageCacheLoader()
    private let imageDownloader = ImageDownloader()
    
    func loadImage(with url: URL, completeHandle: @escaping (UIImage?) -> Void) {
        cacheLoader.loadCacheImage(with: url) { (image) in
            if let image = image {
                /// 从内存或者磁盘读取到
                DispatchQueue.main.async {
                    completeHandle(image)
                }
            } else {
                /// 本地不存在
                self.imageDownloader.downloadImage(with: url) { (image) in
                    if let downloadedImage = image {
                        completeHandle(downloadedImage)
                        /// 下载成功，缓存到内存及文件
                        self.cacheLoader.saveImage(downloadedImage, for: url)
                    } else {
                        /// 下载失败
                        completeHandle(nil)
                    }
                }
            }
        }
    }
    
}
