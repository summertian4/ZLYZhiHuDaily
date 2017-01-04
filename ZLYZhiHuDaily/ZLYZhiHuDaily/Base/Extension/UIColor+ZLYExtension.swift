//
//  UIColor+ZLYExtension.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/29.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit

extension UIColor {
    static func zly_hex(_ hexString: String?) -> UIColor {
        guard hexString != nil else {
            return UIColor.clear
        }
        
        //删除字符串中的空格
        var cString = hexString!.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
        
        guard cString.characters.count >= 6 else {
            return UIColor.clear
        }
        
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if cString.hasPrefix("0X") {
            cString = cString.zly_subString(from: 2)
        }
        
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") {
            cString = cString.zly_subString(to: 1)
        }
        
        guard cString.characters.count == 6 else {
            return UIColor.clear
        }
        
        //r
        let rString = cString.zly_subString(start: 0, end: 2)
        //g
        let gString = cString.zly_subString(start: 2, end: 4)
        //b
        let bString = cString.zly_subString(start: 4, end: 6)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

