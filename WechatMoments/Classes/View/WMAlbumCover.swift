//
//  WMAlbumCover.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/30.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

/// 相册封面
class WMAlbumCover: UIView {
    
    /// 封面
    lazy var profileImageView = UIImageView()
    /// 头像
    lazy var avatar = UIImageView()
    /// 昵称
    lazy var nickLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        clipsToBounds = true
        profileImageView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        profileImageView.contentMode = .scaleAspectFill
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-45)
        }
        
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 8
        avatar.layer.masksToBounds = true
        addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        nickLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nickLabel.textColor = .white
        addSubview(nickLabel)
        nickLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(avatar.snp.leading).offset(-20)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-10)
        }
    }
    
    /// 数据刷新
    func refresh(data: User) {
        nickLabel.text = data.nick
        if let profileUrl = URL(string: data.profileImage) {
            profileImageView.sd_setImage(with: profileUrl)
        }
        if let avatarUrl = URL(string: data.avatar) {
            avatar.sd_setImage(with: avatarUrl)
        }
    }

}
