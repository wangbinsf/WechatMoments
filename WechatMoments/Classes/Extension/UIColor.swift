//
//  UIColor.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/4.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
 
extension UIColor {
    class var random: UIColor {
        return UIColor(displayP3Red: CGFloat.random(in: 0...255) / 255.0, green: CGFloat.random(in: 0...255) / 255.0, blue: CGFloat.random(in: 0...255) / 255.0, alpha: 1.0)
    }
}
