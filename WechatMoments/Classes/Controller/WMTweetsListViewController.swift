//
//  WMTweetsListViewController.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class WMTweetsListViewController: UIViewController {

    /// 当前页，从0开始
    var currentPage = 0
    private let pageNum = 5
    
    lazy var naviBar = WMCustomNavBar()
    var tableView: UITableView!
    var tweets: [WMTweetModel] = [] {
        didSet {
            tableAdapter.tweets = tweets
        }
    }
    private var dataProvier = WMBundleDataProvider()
    private var tableAdapter = WMTweetTableViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// table
        configureTableView()
        /// table相关配置
        setupTableAdapter()
        /// 导航栏
        configureNaviBar()
        fetchTweets(ofPage: 0)
    }
    
    private func fetchTweets(ofPage: Int) {
        dataProvier.requestTweets(currentPage: currentPage, pageNum: pageNum) { [weak self] tweets in
            guard let self = self else { return }
            if self.currentPage == 0 {
                self.tweets = tweets
                self.tableView.mj_footer.resetNoMoreData()
                self.tableView.mj_header.endRefreshing()
                
            } else {
                self.tweets.append(contentsOf: tweets)
                if tweets.count < self.pageNum {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer.endRefreshing()
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func configureNaviBar() {
        view.addSubview(naviBar)
//        naviBar.title = "朋友圈"
//        naviBar.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(44 + 44)
//        }
    }
    
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetTextContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetImageContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetMultipleImageContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetTextImageContentView.self)")
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            guard let self = self else { return }
            self.currentPage = 0
            self.fetchTweets(ofPage: self.currentPage)
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.currentPage += 1
            self.fetchTweets(ofPage: self.currentPage)
        })
    }
    
    private func setupTableAdapter() {
        
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
    }
    
}



