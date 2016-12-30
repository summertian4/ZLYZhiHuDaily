//
//  ZLYHomepageViewController.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class ZLYHomepageViewController: ZLYViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    private var dailyNews: Array<ZLYDailyNews>? = Array<ZLYDailyNews>()
    
    private var tableHeaderHeight: CGFloat = 45

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
    
    @objc private func refreshData() {
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
    
    // MARK: - ========================= UI Config =========================
    
    private func configSubviews() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(ZLYNewsCell.self, forCellReuseIdentifier: ZLYNewsCell.identifier)
        self.tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        self.configRefreshUI()
        self.refreshTableView()
    }
    
    func refreshTableView() {
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        self.tableView.reloadData()
    }
    
    private func configRefreshUI() {
        // 添加下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.refreshData()
        })
        // 添加上拉
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.fetchMoreData()
        })
    }
    
    // MARK: - ========================= UITableViewDataSource & UITableViewDelegate =========================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dailyNews?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.dailyNews?[section].stories?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZLYNewsCell.identifier, for: indexPath) as! ZLYNewsCell
        if let model = self.dailyNews?[indexPath.section].stories?[indexPath.row] {
            cell.model = model
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: ZLYGlobalTool.screenWidth!, height: self.tableHeaderHeight)
        headerView.backgroundColor = ZLYGlobalTool.themeColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: ZLYGlobalTool.screenWidth!, height: self.tableHeaderHeight))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 14)
        
        if let dateStr = self.dailyNews?[section].date {
            let string = Date.date(fromyyyyMMMMdd: dateStr)?.MMMM月dd日EEEE
            label.text = string
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
