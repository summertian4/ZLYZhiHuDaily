//
//  ZLYNews.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import ObjectMapper

class ZLYNews: Mappable {
    var images: Array<String>? = Array<String>()
    // topStories 使用
    var image: String = ""
    
    var type: Int = 0
    var news_id: Int = 0
    var title: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        images <- map["images"]
        image <- map["image"]
        type <- map["type"]
        news_id <- map["id"]
        title <- map["title"]
    }
}
