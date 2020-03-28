//
//  WMTweetCellTableViewCell.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit
//import SnapKit


class WMTweetCell: UITableViewCell {

    lazy var avatarImageView = WMAvatarImageView()
    lazy var nickLabel = UILabel()
    
    var model: WMTweetModel?
    var customContentView: WMTweetContentView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureComponents() {
        /// avatar
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        /// nick name
        contentView.addSubview(nickLabel)
        nickLabel.isOpaque = true
        nickLabel.backgroundColor = .clear
        nickLabel.font = WMConfig.shared.nickFont
        nickLabel.textColor = WMConfig.shared.nickColor
        
        /// content view
        /// 可自行扩展
        /// comments
        
    }
    
    func configureUI() {
        
        
    }
    
    func refreshData(_ model: WMTweetModel) {
        self.model = model
        refresh()
    }
    
    /// 控件赋值
    func refresh() {
        addContentView()
        nickLabel.text = model?.sender?.nick
//        avatarImageView.image =
    }

    func addContentView() {
        let config = WMConfig.shared.layoutConfig
        guard let model = model else {
            assert(false)
            return
        }
        let contentClassName = config.cellClass(model: model)
        assert(!contentClassName.isEmpty, "须提供自定义内容视图的类名")
        //1:动态获取命名空间
        guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取命名空间失败")
            return
        }
        let vcClass: AnyClass? = NSClassFromString(spaceName + "." + contentClassName)
        guard let typeClass = vcClass as? WMTweetContentView.Type else {
             print("vcClass不能当做WMTweetContentView")
             return
         }
        let content = typeClass.init()
        customContentView = content
        contentView.addSubview(content)
        layoutCustomContentView()
    }
    
    func layoutCustomContentView() {
        guard let model = model else {
            assert(false, "model不存在")
            return
        }
//        let origin = WMConfig.shared.layoutConfig.contentOrigin(model: model)
//        let size = WMConfig.shared.
//        customContentView?.snp.makeConstraints({ (make) in
//            make.edges.equalTo(edgeInsets)
//        })
    }
}
