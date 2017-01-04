//
//  Date+ZLYExtension.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/29.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import Foundation

extension Date {
    var MMMM月dd日EEEE: String {
        let fommater = DateFormatter()
        fommater.dateFormat = "MM月dd日 EEEE"
        return fommater.string(from: self)
    }
    
    static func date(fromyyyyMMMMdd: String) -> Date? {
        let fommater = DateFormatter()
        fommater.dateFormat = "yyyyMMdd"
        return fommater.date(from: fromyyyyMMMMdd)
    }
    
}
