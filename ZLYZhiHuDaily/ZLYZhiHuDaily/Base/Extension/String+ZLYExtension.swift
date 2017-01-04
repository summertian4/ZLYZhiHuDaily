//
//  String+ZLYExtension.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/29.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import Foundation

extension String {
    func zly_subString(start: Int, end: Int) -> String {
        let range = self.index(self.startIndex, offsetBy: start) ..< self.index(self.startIndex, offsetBy: end)
        let string = self.substring(with: range)
        return string
    }
    
    func zly_subString(from: Int) -> String {
        let range = self.index(self.startIndex, offsetBy: from) ..< self.endIndex
        let string = self.substring(with: range)
        return string
    }
    
    func zly_subString(to: Int) -> String {
        return self.zly_subString(start: 0, end: to)
    }
}
