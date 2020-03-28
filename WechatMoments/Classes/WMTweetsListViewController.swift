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
    var tweets: [WMTweetModel] = []
    var dataProvier: WMDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// table
        configureTableView()
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
        naviBar.title = "朋友圈"
        naviBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44 + 44)
        }
    }
    
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "WMTweetCell")
    }
    
}

extension WMTweetsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WMTweetCell", for: indexPath) as! WMTweetCell
        let model = tweets[indexPath.row]
        cell.refreshData(model)
        return cell
    }
}

