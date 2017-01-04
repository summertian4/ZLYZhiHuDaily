//
//  ZLYCycleScrollView.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/30.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import SDCycleScrollView

class ZLYCycleScrollView: UIView, SDCycleScrollViewDelegate {
    // 自高
    var height: CGFloat = 220
    // 模型
    var topStories: Array<ZLYNews>? {
        didSet {
            if let stories = topStories {
                self.images = Array<String>()
                self.titles = Array<String>()
                for news in stories {
                    self.images?.append(news.image)
                    self.titles?.append(news.title)
                }
            }
            self.cycleScrollView.imageURLStringsGroup = self.images
            self.cycleScrollView.titlesGroup = self.titles
        }
    }
    static var identifier = "ZLYCycleScrollView"
    
    // 图片数组
    var images: Array<String>? = Array<String>()
    // 标题
    var titles: Array<String>? = Array<String>()
    // 图片轮播器
    private var cycleScrollView: SDCycleScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let frame = CGRect(x: 0, y: 0, width: ZLYGlobalTool.screenWidth, height: self.height)
        self.cycleScrollView = SDCycleScrollView(frame: frame, delegate: self, placeholderImage: nil)
        self.cycleScrollView.autoScrollTimeInterval = 5.0
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentMode.scaleAspectFill
        self.cycleScrollView.titleLabelHeight = 80
        self.addSubview(self.cycleScrollView)
        self.cycleScrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(self)
        }
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
