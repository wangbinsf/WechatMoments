//
//  WMTweetTableViewAdapter.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/29.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetTableViewAdapter: NSObject {
    var tweets: [WMTweetModel] = []
    /// 缓存高度
    var cellHeights: [IndexPath: CGFloat] = [:]
    override init() {
        super.init()
        
    }
}

extension WMTweetTableViewAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /// 可通过代理处理展示前的调整
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellH = cellHeights[indexPath]
//        if let height = cellH {
//            return height
//        }
        let tweet = tweets[indexPath.row]
        /// 内容高度
        let layoutConfig = WMConfig.shared.layoutConfig
        let contentTop = layoutConfig.contentInset(model: tweet).top
        let contentSize = layoutConfig.contentSize(model: tweet, width: tableView.frame.width)
        
        /// 评论高度
        let commentsSize = layoutConfig.commentsSize(model: tweet, width: tableView.frame.width).height
        let height = contentTop + contentSize.height + 10 + commentsSize
        cellHeights[indexPath] = height
        return height
    }
}

extension WMTweetTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        let config = WMConfig.shared.layoutConfig
        let reuseIdentifier = config.cellClass(model: tweet)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WMTweetCell
        cell.refreshData(tweet)
        return cell
    }
    
    
}
