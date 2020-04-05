//
//  ImageCache.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/1.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

// 内存缓存协议
protocol ImageCacheProtocol: class {
    // 根据url返回图片
    func image(for url: URL) -> UIImage?
    // 根据url保存图片
    func setImage(_ image: UIImage?, for url: URL)
    // 根据url删除图片
    func removeImage(for url: URL)
    // 删除所有图片
    func removeAllImages()
}


class ImageCache: ImageCacheProtocol {

    // 保存编码之后的数据
    lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    // 保存解码之后的数据
    lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    let config = Config.defaultConfig
    let semphore = DispatchSemaphore(value: 1)
    var ioQueue = DispatchQueue(label: "wechatmoment-queue", qos: .background, attributes: .concurrent)
    var fileManager: FileManager!
    

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }
    
    private init() {
        ioQueue.sync {
            fileManager = FileManager.default
        }
    }
    
    static let shared = ImageCache()

    /// 查询图片
    func image(for url: URL) -> UIImage? {
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
    func setImage(_ image: UIImage?, for url: URL) {
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


     /// 存储照片到本地
    func store(image: UIImage, forKey key: URL, completed: (() -> Void)? = nil) {
        ioQueue.async {
            if let pngRepresentation = image.pngData() {
                if let filePath = self.filePath(forKey: key), let diskPath = self.diskPath() {
                    do {
                        if !self.fileManager.fileExists(atPath: diskPath.absoluteString) {
                            try self.fileManager.createDirectory(at: diskPath, withIntermediateDirectories: true, attributes: nil)
                        }
                        if !self.fileManager.fileExists(atPath: filePath.absoluteString) {
                            self.fileManager.createFile(atPath: filePath.absoluteString, contents: nil, attributes: [:])
                        }
                        try pngRepresentation.write(to: filePath, options: .atomic)
                        if let block = completed {
                            block()
                        }
                    } catch let err {
                        print("Saving results in error: ", err)
                    }
                }
            }
        }
     }
     
     /// 从本地读取照片
    func retrieveImage(forKey key: URL) -> UIImage? {
         if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path),
             let image = UIImage(data: fileData) {
             return image
         }
         return nil
     }
     
    /// 从内存删除图片
    func removeImage(for url: URL) {
        semphore.wait()
        defer {
            semphore.signal()
        }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    /// 从磁盘删除图片
    func removeDiskImage(for url: URL) {
        if let filePath = self.filePath(forKey: url) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch  {
                print(error)
            }
        }
        
    }

    /// 删除所有内存图片
    func removeAllImages() {
        semphore.wait()
        defer {
            semphore.signal()
        }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    /// 删除所有磁盘图片
    func removeAllDiskImage() {
        do {
            if let path = diskPath() {
                try fileManager.removeItem(at: path)
                fileManager.createFile(atPath: path.absoluteString, contents: nil, attributes: [:])
            }
        } catch  {
            print(error)
        }
    }
    
    func filePath(forKey key: URL) -> URL? {
        guard var documentURL = diskPath() else {
            return nil
        }
        documentURL.appendPathComponent("\(MD5(string: key.absoluteString)).png")
        return documentURL
    }
    
    func diskPath() -> URL? {
        guard var documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        documentURL.appendPathComponent("wmCacheImages")
        return documentURL
    }

}

