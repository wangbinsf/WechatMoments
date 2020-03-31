//
//  WMHTTPTool.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/31.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import Alamofire

class WMHTTPTool {
    
    /// 请求用户基本信息
    static func requestUserInfo(completionHandle: @escaping (Result<User, WMError>) -> Void) {
        AF.request(Constants.userInfoUrl).responseData { (response) in
            
            switch response.result {
            case .failure(_):
                let error = WMError.inline(response.error!)
                completionHandle(.failure(error))
            case .success(let data):
                /// 反序列化
                let jsonDecoder = JSONDecoder()
                do {
                    let user = try jsonDecoder.decode(User.self, from: data)
                    completionHandle(.success(user))
                } catch {
                    completionHandle(.failure(.dataParseFailed))
                }
            }
        }
    }
    
    /// 请求推文列表
    static func requestTweetList(completionHandle: @escaping (Result<[WMTweetModel], WMError>) -> Void) {
        AF.request(Constants.tweetsListUrl).responseData { (response) in
            
            switch response.result {
            case .failure(_):
                let error = WMError.inline(response.error!)
                completionHandle(.failure(error))
            case .success(let data):
                /// 反序列化
                let jsonDecoder = JSONDecoder()
                do {
                    let tweets = try jsonDecoder.decode([WMTweetModel].self, from: data)
                    completionHandle(.success(tweets))
                } catch {
                    completionHandle(.failure(.dataParseFailed))
                }
            }
        }
    }
    
}
