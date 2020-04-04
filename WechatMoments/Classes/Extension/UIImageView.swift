//
//  UIImageView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/4.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    
    typealias LoadImageCompletedHandle = (UIImage?) -> Void
    
    func wm_setImage(with url: URL) {
        wm_setImage(with: url, placeholderColor: UIColor.random)
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
