//
//  ZLYHomepageViewController.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/27.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import UIKit
import SnapKit

class ZLYHomepageViewController: ZLYViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableview: UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
    private var dailyNews: Array<ZLYDailyNews>? = Array<ZLYDailyNews>()
    
    private var tableHeaderHeight: CGFloat = 45

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    private func fetchData() {
        ZLYNewsService.fetchLastNews(success: { (lastNews) in
            if let lastNews = lastNews {
                self.dailyNews?.append(lastNews)
                self.configSubviews()
            }
        }, failure: { (error) in
            print("\(error)")
        })
    }
    
    private func configSubviews() {
        self.view.addSubview(self.tableview)
        self.tableview.backgroundColor = UIColor.brown
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.tableFooterView = UIView()
        self.tableview.register(ZLYNewsCell.self, forCellReuseIdentifier: ZLYNewsCell.identifier)
        self.tableview.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
        }
        self.tableview.reloadData()
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
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
        let cell = tableview.dequeueReusableCell(withIdentifier: ZLYNewsCell.identifier, for: indexPath) as! ZLYNewsCell
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
