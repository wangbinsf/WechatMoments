//
//  WMAlbumCover.swift
//  WechatMoments
//
//  Created by 王宾宾 on 2020/3/30.
//  Copyright © 2020 王宾宾. All rights reserved.
//

import UIKit

class WMAlbumCover: UIView {
    
    func refresh(data: String) {
        guard let url = URL(string: data) else { return }
        imageView.sd_setImage(with: url)
    }
    
    lazy var imageView = UIImageView()

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
        imageView.image = #imageLiteral(resourceName: "activityDescription")
        imageView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }

}
