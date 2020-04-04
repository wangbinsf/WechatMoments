//
//  WMDataProvider.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation



class WMBundleDataProvider {
    
    typealias TweetsResponseHandle = ([WMTweetModel]) -> Void
    typealias UserInfoResponseHandle = (User?) -> Void
    
    /// 记录当前请求下标
    var allTweets: [WMTweetModel] = []
    
    /// 获取用户信息
    func fetchUserInfo(completionHandle: @escaping UserInfoResponseHandle) {
        WMHTTPTool.requestUserInfo { (result) in
            switch result {
            case .failure(let error):
                /// 处理错误，上传服务器或其他处理，不要抛给用户
                assert(false)
                print(error)
                completionHandle(nil)
            case .success(let user):
                completionHandle(user)
            }
        }
    }
    
    /// 一次拉去所有数据
    /// 缓存所有数据，并只返回前5条
    func requestTweets(completionHandle: @escaping TweetsResponseHandle) {
        WMHTTPTool.requestTweetList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                /// 处理错误，上传服务器或其他处理，不要抛给用户
                print(error)
                assert(false)
                completionHandle([])
            case .success(let tweets):
                let validData = self.processSourceData(tweets)
                self.allTweets = validData
                completionHandle(Array(validData.prefix(5)))
            }
        }
    }
    
    /// 根据页数、每页条数返回
    /// 根据需要获取数据,默认每次请求pageNum一致
    ///
    /// - Parameters:
    ///   - currentPage: 当前请求页
    ///   - pageNum: 每页数量
    ///
    func fetchTweets(currentPage: Int, pageNum: Int = Constants.numPerPage,  completionHandle: @escaping TweetsResponseHandle) {

        let start = currentPage * pageNum
        let end = start + pageNum
        var result: [WMTweetModel] = []
        if start < allTweets.count && end <= allTweets.count {
            result = Array(allTweets[start..<end])
        } else {
            result = []
        }
        completionHandle(result)
    }
    
}
extension WMBundleDataProvider {
    
    private func processSourceData(_ tweets: [WMTweetModel]) -> [WMTweetModel] {
        /// 解析数据时，拆分合法数据和不合法数据
        /// 合法数据用于展示，不合法数据保存，并上传服务器
        var illegalData: [WMTweetModel] = []
        var legalData: [WMTweetModel] = []
        /// 简单的for循环只需要O(n)
        for tweet in tweets {
            var tweet = tweet
            if checkSourceData(&tweet) {
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
    private func checkSourceData(_ tweet: inout WMTweetModel) -> Bool {
        
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
