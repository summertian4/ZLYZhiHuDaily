//
//  ZLYNewsCell.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import SnapKit

class ZLYNewsCell: ZLYTableViewCell {
    // private
    private var titleTextView: UITextView = UITextView()
    private var titleImageView: UIImageView = UIImageView()
    private var lineView: UIView = UIView()
    
    // public
    
    var model: ZLYNews? {
        didSet {
            if let model = model {
                self.configSubviews(model: model)
            }
        }
    }
    
    // MARK: init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleTextView)
        self.contentView.addSubview(self.titleImageView)
        self.contentView.addSubview(self.lineView)
        self.titleTextView.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.titleTextView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.titleImageView.snp.left).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        self.titleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.right.equalTo(self.contentView).offset(-10)
            make.width.equalTo(100)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(10)
            make.height.equalTo(0.5)
        }
        self.lineView.backgroundColor = UIColor(colorLiteralRed: 0.02, green: 0.02, blue: 0.02, alpha: 0.5)
        self.titleImageView.backgroundColor = UIColor.black
    }
    
    private func configSubviews(model: ZLYNews) {
        self.titleTextView.text = model.title
        let urlStr = model.images?.first
        if let urlStr = urlStr {
            self.titleImageView.sd_setImage(with: URL(string: urlStr))
        }
        
    }
}
