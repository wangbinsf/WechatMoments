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
            var tweet = tweet
            if processingSourceData(&tweet) {
                legalData.append(tweet)
            } else {
                illegalData.append(tweet)
            }
        }
       
        /// 异步IO
        DispatchQueue.global().async {
            WMFileManager.saveErrorData(illegalData)
        }
        return legalData
    }
    
    /// 数据验证
    func processingSourceData(_ tweet: inout WMTweetModel) -> Bool {
        
        /// 错误消息
        if tweet.error != nil || tweet.unknownError != nil {
            return false
        }
        
        /// 发送人为空，删除消息
        guard tweet.sender != nil else {
            return false
        }
        
        /// 纯文本、单张图片、多张图片、文本加图
        if tweet.content != nil {
            /// 存在文本内容
            if tweet.images == nil {
                /// 图片为空
                tweet.contentType = .text
            } else {
                /// 图片不为空
                if tweet.images!.count > 0{
                    tweet.contentType = .text_image
                } else {
                    tweet.contentType = .text
                }
            }
        } else {
            /// 不存在文本
            if tweet.images == nil {
                /// 图片为空
                return false
            } else {
                /// 图片不为空
                if tweet.images!.count == 1 {
                    tweet.contentType = .singleImage
                } else if tweet.images!.count > 1 {
                    tweet.contentType = .mutipleImage
                } else {
                    return false
                }
            }
        }
        return true
    }
    
}
