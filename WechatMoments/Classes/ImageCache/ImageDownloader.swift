//
//  ImageDownloader.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/2.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import Alamofire

class ImageDownloader {
    
    func downloadImage(with url: URL, completedHandle: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { (responseData) in
            if let data = responseData.data {
                let image = UIImage(data: data)
                completedHandle(image)
            } else {
                completedHandle(nil)
            }
        }
    }
}
