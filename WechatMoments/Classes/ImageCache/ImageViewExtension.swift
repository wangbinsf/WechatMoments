//
//  ImageViewExtension.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/2.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    typealias LoadImageCompletedHandle = (UIImage?) -> Void
    
//    func sd_setImage(with url: URL) {
//        wm_setImage(with: url)
//    }
    func wm_setImage(with url: URL) {
        wm_setImage(with: url, placeholderColor: nil)
    }
    
    func wm_setImage(with url: URL, placeholderColor: UIColor?) {
        backgroundColor = placeholderColor
        wm_setImage(with: url, placeholderColor: placeholderColor, completedHandle: nil)
    }
    
    func wm_setImage(with url: URL, placeholderColor: UIColor?, completedHandle: LoadImageCompletedHandle?) {
        let loadManager = ImageLoadManager.shared
        loadManager.loadImage(with: url) { (image) in
            self.image = image
            completedHandle?(image)
        }
    }
}
