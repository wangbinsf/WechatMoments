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
    func loadCacheImage(with url: URL, completionHandle: (UIImage?) -> Void) {
        if let image = ImageCache.shared.image(for: url) {
            /// 1、在内存中查找
            completionHandle(image)
        } else {
            /// 2、如果内存不存在，在磁盘查找
            let image = retrieveImage(forKey: url)
            completionHandle(image)
        }
    }
    
    /// 保存图片
    func saveImage(_ image: UIImage, for url: URL) {
        /// 存储到内存
        ImageCache.shared.setImage(image, for: url)
        /// 存储到磁盘
        store(image: image, forKey: url)
    }
    
    /// 存储照片到本地
    private func store(image: UIImage, forKey key: URL) {
        if let pngRepresentation = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do {
                    ///
                    if !FileManager.default.fileExists(atPath: filePath.path) {
                        FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: [:])
                    }
                    try pngRepresentation.write(to: filePath, options: .atomic)
                } catch let err {
                    print("Saving results in error: ", err)
                }
            }
        }
//        if let jpgeRepresentation = image.jpegData(compressionQuality: 1.0) {
//            if let filePath = filePath(forKey: key) {
//                do {
//                    try jpgeRepresentation.write(to: filePath, options: .atomic)
//                } catch let err {
//                    print("Saving results in error: ", err)
//                }
//            }
//        }
    }
    
    /// 从本地读取照片
    private func retrieveImage(forKey key: URL) -> UIImage? {
        if let filePath = self.filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path),
            let image = UIImage(data: fileData) {
            return image
        }
        return nil
    }
    
    
    private func filePath(forKey key: URL) -> URL? {
        let fileManager = FileManager.default
        guard var documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        documentURL.appendPathComponent(key.lastPathComponent)
        return documentURL
    }
    
}
