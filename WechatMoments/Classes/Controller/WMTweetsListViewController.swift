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
    /// 每页条数
    private let pageNum = 5
    
    lazy var naviBar = WMCustomNavBar()
    var tableView: UITableView!
    private var dataProvier = WMBundleDataProvider()
    private var tableAdapter: WMTweetTableViewAdapter!
    
    var tweets: [WMTweetModel] = [] {
        didSet {
            tableAdapter.tweets = tweets
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// table
        configureTableView()
        /// table相关配置
        setupTableAdapter()
        /// 导航栏
        configureNaviBar()
        /// 请求数据
        fetchTweets(ofPage: 0)
    }
    
    /// 配置导航栏
    private func configureNaviBar() {
        view.addSubview(naviBar)
        naviBar.title = "朋友圈"
        naviBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44 + 20)
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: -Constants.albumCoverTopInset, left: 0, bottom: 0, right: 0)
        let albumCover = WMAlbumCover()
        let coverWH = tableView.bounds.width
        albumCover.frame.size = CGSize(width: coverWH, height: coverWH)
        tableView.tableHeaderView = albumCover
        
        view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            [weak self] in
            guard let self = self else { return }
            self.currentPage = 0
            self.fetchTweets(ofPage: self.currentPage)
        })
        header?.ignoredScrollViewContentInsetTop = -20
        tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.currentPage += 1
            self.fetchTweets(ofPage: self.currentPage)
        })
        footer?.setTitle("我是有底线的", for: .noMoreData)
        tableView.mj_footer = footer
        
    }
    
    private func setupTableAdapter() {
        tableAdapter = WMTweetTableViewAdapter(viewController: self)
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
    }
    
    /// 请求数据
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
    
}

