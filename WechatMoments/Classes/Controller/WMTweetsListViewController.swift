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
    var tableView: UITableView!
    lazy var naviBar = WMCustomNavBar()
    private var dataProvier = WMBundleDataProvider()
    private var albumCover = WMAlbumCover()
    private var tableAdapter: WMTweetTableViewAdapter!
    private let indicator = UIActivityIndicatorView(style: .large)
    
    var tweets: [WMTweetModel] = [] {
        didSet {
            tableAdapter.tweets = tweets
            tableAdapter.reloadData()
        }
    }
    
    func showIndicator() {
        indicator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view.addSubview(indicator)
        view.bringSubviewToFront(indicator)
        indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        indicator.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        /// table
        configureTableView()
        /// table相关配置
        setupTableAdapter()
        /// 导航栏
        configureNaviBar()
        /// 请求用户信息
        dataProvier.fetchUserInfo { [weak self] (user) in
            guard let self = self else { return }
            guard let user = user else {
                return
            }
            self.albumCover.refresh(data: user)
        }
        /// 请求推文列表
        showIndicator()
        dataProvier.requestTweets { [weak self] (tweets) in
            self?.hideIndicator()
            self?.tableView.mj_footer.isHidden = false
            self?.tweets = tweets
        }
    }
    
    /// 配置导航栏
    private func configureNaviBar() {
        view.addSubview(naviBar)
        naviBar.title = "朋友圈"
        naviBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            let height = Constants.isFullScreen ? 88 : 64
            make.height.equalTo(height)
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
//        header?.ignoredScrollViewContentInsetTop = -20
        tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            self.currentPage += 1
            self.fetchTweets(ofPage: self.currentPage)
        })
        footer?.setTitle("我是有底线的", for: .noMoreData)
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
    }
    
    private func setupTableAdapter() {
        tableAdapter = WMTweetTableViewAdapter(viewController: self)
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
    }
    
    /// 请求数据
    private func fetchTweets(ofPage: Int) {
        
        dataProvier.fetchTweets(currentPage: currentPage) { [weak self] (tweets) in
            guard let self = self else { return }
            if self.currentPage == 0 {
                self.tweets = tweets
                self.tableView.mj_footer.resetNoMoreData()
                self.tableView.mj_header.endRefreshing()
            } else {
                self.tweets.append(contentsOf: tweets)
                if tweets.count < Constants.numPerPage {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self.tableView.mj_footer.endRefreshing()
                }
            }
            
            self.tableAdapter.reloadData()
        }

    }
    
}

