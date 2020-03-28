//
//  WMTweetsListViewController.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetsListViewController: UIViewController {

    let navi = WMCustomNavBar()
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navi.backgroundColor = .green
        view.addSubview(navi)
        navi.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64)
        loadDataFromBundle()
    }
    
    private func configureNaviBar() {
        
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        view.addSubview(tableView)
    }
    
}
/// 数据转换
extension WMTweetsListViewController {
    func loadDataFromBundle() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "homework", withExtension: "json"), let data = try? Data(contentsOf: url) else { return }
        
        let tweets = WMModelResolver().fetchTweets(from: data)
        
        print(tweets)
        
    }
}
