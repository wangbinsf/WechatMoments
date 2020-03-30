//
//  WMDataProvider.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
/// 可以通过协议封装数据请求的接口，以便以后更改数据来源


typealias ResponseHandle = ([WMTweetModel]) -> Void


protocol WMDataProvider {
    func requestTweets(completionHandle: ResponseHandle)
    func requestTweets(currentPage: Int, pageNum: Int, completionHandle: ResponseHandle)
}

struct WMBundleDataProvider: WMDataProvider {
    
    /// 记录当前请求下标
    var currentIndex = 0
    
    /// 一次拉去所有数据
    func requestTweets(completionHandle: ResponseHandle) {
        let tweets = loadDataFromBundle()
        completionHandle(tweets)
    }
    
    /// 根据页数、每页条数返回
    /// 根据需要获取数据,默认每次请求pageNum一致
    ///
    /// - Parameters:
    ///   - currentPage: 当前请求页
    ///   - pageNum: 每页数量
    ///
    func requestTweets(currentPage: Int, pageNum: Int, completionHandle: ResponseHandle) {
        let allTweets = loadDataFromBundle()
        /// 一次获取所有
        guard pageNum < allTweets.count else {
            requestTweets(completionHandle: completionHandle)
            return
        }
        /// 此处需考虑每页数据不一致情况
//        let start = currentIndex
//        let end = start + pageNum
//        let result = Array(allTweets[currentIndex..<end])
//        currentIndex = end
        
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
    
    private func loadDataFromBundle() -> [WMTweetModel] {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: "homework", withExtension: "json"), let data = try? Data(contentsOf: url) else { return [] }
        let result = WMModelResolver().fetchTweets(from: data)
        return result
    }
}
