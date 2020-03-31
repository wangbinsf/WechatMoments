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
    
    var model: WMTweetModel!
    var customContentView: WMTweetContentView!
    var commentsContentView: WMCommentsView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
        configureComponents()
    }
    
    /// 配置默认控件
    func configureComponents() {
        /// avatar
        avatarImageView.frame = CGRect(x: 20, y: 15, width: 44, height: 44)
        contentView.addSubview(avatarImageView)
        
        /// nick name
        contentView.addSubview(nickLabel)
        nickLabel.isOpaque = true
//        nickLabel.backgroundColor = .clear
        nickLabel.font = WMConfig.shared.nickFont
        nickLabel.textColor = WMConfig.shared.nickColor
        nickLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.top.equalTo(avatarImageView)
            make.trailing.greaterThanOrEqualToSuperview().offset(-10)
        }
        
        /// cell分割线
        let cuttingLine = UIView()
        cuttingLine.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        addSubview(cuttingLine)
        cuttingLine.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    /// 数据刷新
    func refreshData(_ model: WMTweetModel) {
        self.model = model
        refresh()
    }
    
    /// 控件赋值
    func refresh() {
        addContentView()
        guard let model = model else {
            assert(false, "非法数据")
            return
        }
        /// 添加评论视图
        if let comments = model.comments, comments.count > 0 {
            addCommentsView()
        } else {
            /// 移除评论视图
            commentsContentView?.removeFromSuperview()
        }
        if let sender = model.sender {
            nickLabel.text = sender.nick
            avatarImageView.setAvatar(sender.avatar)
        }
        customContentView?.refresh(data: model)
    }

    func addContentView() {
        if customContentView != nil {
            customContentView.removeFromSuperview()
            customContentView = nil
        }
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
        let config = WMConfig.shared.layoutConfig
        let edges = config.contentInset(model: model)
        let size = config.contentSize(model: model, width: frame.width)
        
        customContentView?.snp.makeConstraints({ (make) in
            make.leading.equalTo(edges.left)
            make.top.equalTo(edges.top)
            make.trailing.equalTo(-edges.right)
            make.height.equalTo(size.height)
        })
    }
    
    /// 添加评论视图
    func addCommentsView() {
        commentsContentView?.removeFromSuperview()
        commentsContentView = WMCommentsView()
        commentsContentView?.refreshData(comments: model.comments!)
        commentsContentView!.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        commentsContentView?.layer.cornerRadius = 5
        
        contentView.addSubview(commentsContentView!)
        commentsContentView!.snp.makeConstraints { (make) in
            make.leading.equalTo(nickLabel)
            make.top.equalTo(customContentView.snp.bottom)
            make.trailing.equalTo(customContentView)
        }
    }
}
