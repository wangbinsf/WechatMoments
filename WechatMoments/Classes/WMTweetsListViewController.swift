//
//  WMTweetsListViewController.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetsListViewController: UIViewController {

    var navi: WMCustomNavBar!
    var tableView: UITableView!
    var tweets: [WMTweetModel] = []
    var dataProvier: WMDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        view.backgroundColor = .white
        
        
        
        configureTableView()
        tableView.register(WMTweetCell.self, forCellReuseIdentifier: "WMTweetCell")
        
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
        navi = WMCustomNavBar()
        navi.backgroundColor = .green
        view.addSubview(navi)
        navi.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64)
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
    }
    
}

extension WMTweetsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WMTweetCell", for: indexPath) as! WMTweetCell

        return cell
    }
}

