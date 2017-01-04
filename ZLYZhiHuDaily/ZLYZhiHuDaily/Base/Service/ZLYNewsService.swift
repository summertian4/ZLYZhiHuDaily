//
//  ZLYNewsService.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/28.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class ZLYNewsService: NSObject {
    
    /// 获取最新消息
    ///
    /// - Parameters:
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func fetchLastNews(success: @escaping (ZLYDailyNews?) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request("http://news-at.zhihu.com/api/4/news/latest").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let lastNews = Mapper<ZLYDailyNews>().map(JSONObject: value)
                success(lastNews)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /// 查询过往消息
    ///
    /// 若果需要查询 11 月 18 日的消息，before 后的数字应为 20131119
    /// 知乎日报的生日为 2013 年 5 月 19 日，若 before 后数字小于 20130520 ，只会接收到空消息
    /// - Parameters:
    ///   - dateStr: 当天日期 string
    ///   - success: 成功回调
    ///   - failure: 失败回调
    static func fetchBeforeNews(dateStr: String, success: @escaping (ZLYDailyNews?) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request("http://news-at.zhihu.com/api/4/news/before/\(dateStr)").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let lastNews = Mapper<ZLYDailyNews>().map(JSONObject: value)
                success(lastNews)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
