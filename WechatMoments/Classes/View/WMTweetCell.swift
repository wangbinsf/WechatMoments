//
//  WMTweetCellTableViewCell.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/28.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMTweetCell: UITableViewCell {

    var avatar: UIImageView!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        avatar.backgroundColor = .red
        contentView.addSubview(avatar)
    }
    
}
