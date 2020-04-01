//
//  CacheType.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/1.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

/// 图片从网络获取到显示在屏幕上，主要经过以下三步
/// 1、加载经压缩的数据到内存
/// 2、从内存读取压缩数据，把图片从PNG或JPEG等格式中解压出来，得到像素数据
/// 3、CPU、GPU合作渲染图片到屏幕

// Declares in-memory image cache
public protocol ImageCacheProtocol: class {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    // Removes the image of the specified url in the cache
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Accesses the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}
