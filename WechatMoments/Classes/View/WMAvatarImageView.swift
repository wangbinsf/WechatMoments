//
//  WMAvatarImageView.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMAvatarImageView: UIControl {
    
    private lazy var imageView = UIImageView()
    private var cornerRadius: CGFloat = 0.0
    
    private var originalImage: UIImage?
    var image: UIImage {
        set {
            if originalImage != nil {
                return
            }
            originalImage = addCorner(radius: cornerRadius, for: newValue)
        }
        get {
            return originalImage ?? UIImage(named: "placeholderAvatar")!
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        setRadius()
    }
    
    private func setRadius() {
        let avatarStyle = WMConfig.shared.avatarStyle
        switch avatarStyle {
        case .normal:
            cornerRadius = 0.0
        case .rounded:
            cornerRadius = frame.width * 0.5
        case .radiusCorner:
            cornerRadius = 6.0
        case .none:
            cornerRadius = 0.0
        }
    }

}


extension WMAvatarImageView {
    
    ///  给原图添加圆角
    /// 后期为UIImage添加扩展
    func addCorner(radius: CGFloat, for image: UIImage) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        ctx?.addPath(path)
        ctx?.clip()
        image.draw(in: rect)
        ctx?.drawPath(using: .fillStroke)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
