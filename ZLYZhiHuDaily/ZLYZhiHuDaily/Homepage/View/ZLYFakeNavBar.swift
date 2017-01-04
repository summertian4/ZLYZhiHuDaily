//
//  ZLYFakeNavBar.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2017/1/4.
//  Copyright © 2017年 微鲸科技. All rights reserved.
//

import UIKit

class ZLYFakeNavBar: UIView {
    
    enum Mode {
        // 半透明
        case Translucence(alpha: CGFloat)
        // 仅保留 status bar 部分
        case OnlyStatusBar
    }
    
    // 自高
    var height: CGFloat = 64
    var mode: Mode = Mode.Translucence(alpha: 0.0) {
        didSet {
            self.config(mode: mode)
        }
    }
    
    var title: String? = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    private var statusBarBg: UIView = UIView()
    private var contentView: UIView = UIView()
    
    private var titleLabel: UILabel = UILabel()
    private var leftButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.statusBarBg)
        self.addSubview(self.contentView)
        self.addSubview(self.leftButton)
        self.addSubview(self.titleLabel)
        self.statusBarBg.backgroundColor = ZLYGlobalTool.themeColor
        self.contentView.backgroundColor = ZLYGlobalTool.themeColor
        self.contentView.alpha = 0
        self.statusBarBg.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self).offset(20)
        }
        self.statusBarBg.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(20)
        }
        self.titleLabel.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(10)
        }
        self.leftButton.snp.remakeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self).offset(10)
            make.height.width.equalTo(25)
        }
        self.leftButton.backgroundColor = UIColor.white
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.textColor = UIColor.white
    }
    
    func config(mode: Mode) {
        switch mode {
        case Mode.Translucence(let alpha):
            self.statusBarBg.alpha = alpha
            self.contentView.alpha = alpha
            self.titleLabel.alpha = 1.0
            break
        case Mode.OnlyStatusBar:
            self.statusBarBg.alpha = 1.0
            self.contentView.alpha = 0.0
            self.titleLabel.alpha = 0.0
            break
        }
    }
}
