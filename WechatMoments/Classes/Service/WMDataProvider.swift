//
//  WMDataProvider.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import Foundation
/// 可以通过协议封装数据请求的接口，以便以后更改数据来源

protocol WMDataProvider {
    func requestTweets(completionHandle: (([WMTweetModel]) -> Void))
}

struct WMBundleDataProvider: WMDataProvider {
    
    func requestTweets(completionHandle: (([WMTweetModel]) -> Void)) {
        let tweets = loadDataFromBundle()
        completionHandle(tweets)
    }
    
    private func loadDataFromBundle() -> [WMTweetModel] {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: "homework", withExtension: "json"), let data = try? Data(contentsOf: url) else { return [] }
        let result = WMModelResolver().fetchTweets(from: data)
        return result
    }
}
