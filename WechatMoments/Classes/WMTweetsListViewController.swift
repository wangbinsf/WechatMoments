//
//  WMTweetsListViewController.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
import SnapKit

class WMTweetsListViewController: UIViewController {

    lazy var naviBar = WMCustomNavBar()
    var tableView: UITableView!
    var tweets: [WMTweetModel] = [] {
        didSet {
            tableAdapter.tweets = tweets
        }
    }
    var dataProvier: WMDataProvider!
    var tableAdapter = WMTweetTableViewAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// table
        configureTableView()
        /// table相关配置
        setupTableAdapter()
        /// 导航栏
        configureNaviBar()
        /// 数据源
        configureDataProvider()
    }
    
    private func configureDataProvider() {
        
        dataProvier = WMBundleDataProvider()
        dataProvier.requestTweets { [weak self] (tweets) in
            self?.tweets = tweets
            self?.tableView.reloadData()
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
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetTextContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetImageContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetMultipleImageContentView.self)")
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "\(WMTweetTextImageContentView.self)")
    }
    
    private func setupTableAdapter() {
        
        tableView.delegate = tableAdapter
        tableView.dataSource = tableAdapter
    }
    
}



