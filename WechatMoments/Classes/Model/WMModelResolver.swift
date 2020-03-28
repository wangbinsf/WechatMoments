//
//  WMModelResolver.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation

struct WMModelResolver {
    
    /// 获取推文
    func fetchTweets(from data: Data) -> [WMTweetModel] {
        var tweets: [WMTweetModel] = []
        do {
            let decoder = JSONDecoder()
            tweets = try decoder.decode([WMTweetModel].self, from: data)
        } catch {
//            print(error)
        }
        /// 解析数据时，拆分合法数据和不合法数据
        /// 合法数据用于展示，不合法数据保存，并上传服务器
        var illegalData: [WMTweetModel] = []
        var legalData: [WMTweetModel] = []
        /// 简单的for循环只需要O(n)
        for tweet in tweets {
            if tweet.error != nil || tweet.unknownError != nil {
                illegalData.append(tweet)
            } else {
                legalData.append(tweet)
            }
        }
        /// 异步IO
        DispatchQueue.global().async {
            WMFileManager.saveErrorData(illegalData)
        }
        return legalData
    }
    
    
    
    
}
