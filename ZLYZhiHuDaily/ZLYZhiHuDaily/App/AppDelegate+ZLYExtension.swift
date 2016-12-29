//
//  AppDelegate+ZLYExtension.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import Foundation
import CocoaLumberjack
import SwiftyJSON

extension AppDelegate {
    func initWindow() {
        self.window = UIWindow()
        self.window?.backgroundColor = UIColor.white
        let nav = ZLYNavigationController(rootViewController: ZLYHomepageViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
}
