//
//  ImageCache.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/1.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

public final class ImageCache: ImageCacheProtocol {


    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    private let lock = NSLock()
    private let config: Config
    let semphore = DispatchSemaphore(value: 0)

    public struct Config {
        public let countLimit: Int
        public let memoryLimit: Int

        public static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    public init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    public func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        semphore.wait()
        defer {
            semphore.signal()
        }
        // the best case scenario -> there is a decoded image in memory
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }

    public func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decompressedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decompressedImage, forKey: url as AnyObject, cost: 1)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decompressedImage.diskSize)
    }

    public func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

