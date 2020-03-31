//
//  Constants.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/30.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import UIKit

enum WMError: Error {
    case dataParseFailed
    /// AF抛出来的错误
    case inline(Error)
}

struct Constants {
    
    /// api
    static let tweetsListUrl = "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith/tweets"
    static let userInfoUrl = "https://thoughtworks-mobile-2018.herokuapp.com/user/jsmith"
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let albumCoverTopInset: CGFloat = 80
    /// 推文每页条数
    static let numPerPage = 5
    
    static var isFullScreen: Bool {
        if #available(iOS 11, *) {
            guard let window = UIApplication.shared.delegate?.window, let unwrapedWindow = window else {
                return false
            }
            
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                print(unwrapedWindow.safeAreaInsets)
                return true
            }
        }
        return false
    }
}
