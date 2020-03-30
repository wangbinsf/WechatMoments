//
//  WMCustomNavBar.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

/// 微信的相册封面是一张正方形图片
class WMCustomNavBar: UIView {
    
    var title: String {
        set {
            titleView.text = newValue
        }
        get {
            return titleView.text ?? ""
        }
    }
    
    
    
    lazy var contentView = UIView()

    lazy var titleView: UILabel = {
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 18)
        titleView.textColor = UIColor.clear
        titleView.textAlignment = .center
        return titleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    /// 根据透明度刷新ui
    func updateUI(alpha: CGFloat) {
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1).withAlphaComponent(alpha)
        titleView.textColor = UIColor.black.withAlphaComponent(alpha)
    }
}
