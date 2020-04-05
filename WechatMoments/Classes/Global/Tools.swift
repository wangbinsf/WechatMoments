//
//  Tools.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/4/4.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
import CryptoKit

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
