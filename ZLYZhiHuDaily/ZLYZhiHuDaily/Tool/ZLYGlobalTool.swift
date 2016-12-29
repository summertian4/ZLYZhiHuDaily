//
//  ZLYGlobalTool.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/29.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit

class ZLYGlobalTool: NSObject {
    
    static var screenWidth: CGFloat? {
        return UIApplication.shared.keyWindow?.bounds.width
    }
    
    static var screenHeight: CGFloat? {
        return UIApplication.shared.keyWindow?.bounds.height
    }
    
    static var themeColor = UIColor.zly_hex("00b7ee")
}
