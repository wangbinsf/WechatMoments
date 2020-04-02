//
//  ImageCache.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/1.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

// 内存缓存协议
public protocol ImageCacheProtocol: class {
    // 根据url返回图片
    func image(for url: URL) -> UIImage?
    // 根据url保存图片
    func setImage(_ image: UIImage?, for url: URL)
    // 根据url删除图片
    func removeImage(for url: URL)
    // 删除所有图片
    func removeAllImages()
}


public final class ImageCache: ImageCacheProtocol {

    // 保存编码之后的数据
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    // 保存解码之后的数据
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let config = Config.defaultConfig
    private let semphore = DispatchSemaphore(value: 1)

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }
    
    private init() {}
    static let shared = ImageCache()

    /// 查询图片
    public func image(for url: URL) -> UIImage? {
        semphore.wait()
        defer {
            semphore.signal()
        }
        /// 从编码容器里查询
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        
        /// 从未编码容器查询
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        
        /// 查询失败
        return nil
    }

    /// 保存图片
    public func setImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        /// 图片编码
        let decompressedImage = image.decodedImage()
        semphore.wait()
        defer {
            semphore.signal()
        }
        imageCache.setObject(decompressedImage, forKey: url as AnyObject, cost: 1)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decompressedImage.diskSize)
    }

    public func removeImage(for url: URL) {
        semphore.wait()
        defer {
            semphore.signal()
        }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAllImages() {
        semphore.wait()
        defer {
            semphore.signal()
        }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

}

