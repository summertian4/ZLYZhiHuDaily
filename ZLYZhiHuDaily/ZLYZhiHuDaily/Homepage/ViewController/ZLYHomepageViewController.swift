//
//  ZLYHomepageViewController.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import SnapKit

class ZLYHomepageViewController: ZLYViewController {
    
    var tableView: UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    var dailyNews: Array<ZLYDailyNews>? = Array<ZLYDailyNews>()
    
    var tableHeaderHeight: CGFloat = 45

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configSubviews()
        self.fetchTodayData()
    }
    
    // MARK: - ========================= Data Config =========================
    
    private func fetchTodayData() {
        ZLYNewsService.fetchLastNews(success: { (lastNews) in
            if let lastNews = lastNews {
                var newDailyNews: Array<ZLYDailyNews>? = Array<ZLYDailyNews>()
                newDailyNews?.append(lastNews)
                self.dailyNews = newDailyNews
                self.refreshTableView()
            }
        }, failure: { (error) in
            print("\(error)")
        })
    }
    
    @objc func refreshData() {
        self.fetchTodayData()
    }
    
    func fetchMoreData() {
        if let dateStr = self.dailyNews?.last?.date {
            ZLYNewsService.fetchBeforeNews(dateStr: dateStr, success: { (lastNews) in
                if let lastNews = lastNews {
                    self.dailyNews?.append(lastNews)
                    self.refreshTableView()
                }
            }, failure: { (error) in
                print("\(error)")
                self.refreshTableView()
            })
        }
    }
}
