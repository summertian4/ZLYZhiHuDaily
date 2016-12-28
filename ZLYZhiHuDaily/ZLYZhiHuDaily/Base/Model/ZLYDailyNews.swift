//
//  ZLYDailyNews.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/28.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import ObjectMapper

class ZLYDailyNews: Mappable {
    var date: String?
    var stories: Array<ZLYNews>?
    var topStories: Array<ZLYNews>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        stories <- map["stories"]
        topStories <- map["top_stories"]
    }
}
