//
//  ZLYGlobalTool.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/29.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit

class ZLYGlobalTool: NSObject {
    
    static var screenWidth: CGFloat {
        if let width = UIApplication.shared.keyWindow?.bounds.width {
            return width
        }
        return 375.0
    }
    
    static var screenHeight: CGFloat {
        if let height = UIApplication.shared.keyWindow?.bounds.height {
            return height
        }
        return 667.0
    }
    
    static var themeColor = UIColor.zly_hex("00b7ee")
}
