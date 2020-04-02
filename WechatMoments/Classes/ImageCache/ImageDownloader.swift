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
    
    // "https://thoughtworks-mobile-2018.herokuapp.com/images/user/avatar/008.jpeg"
    func downloadImage(with url: URL, completedHandle: @escaping (UIImage?) -> Void) {
//        let destination: DownloadRequest.Destination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let fileName = url.absoluteString
//            let fileURL = documentsURL.appendingPathComponent(fileName)
//
//            return (fileURL, [.removePreviousFile])
//        }
//        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//        AF.download(url, to: destination).response { response in
//            debugPrint(response)
//
//            if response.error == nil, let imagePath = response.fileURL?.path {
//                let image = UIImage(contentsOfFile: imagePath)
//                completedHandle(image)
//            } else {
//                completedHandle(nil)
//            }
//        }
        AF.request(url).responseData { (responseData) in
            if let data = responseData.data {
                let image = UIImage(data: data)
                completedHandle(image)
            } else {
                completedHandle(nil)
            }
//           if response.error == nil, let imagePath = response.fileURL?.path {
//                let image = UIImage(contentsOfFile: imagePath)
//                completedHandle(image)
//            } else {
//                completedHandle(nil)
//            }
        }
    }
}
