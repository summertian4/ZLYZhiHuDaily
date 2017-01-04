//
//  ZLYHomepageViewController+ZLYLayout.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/30.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import Foundation
import MJRefresh

extension ZLYHomepageViewController {
    // MARK: - ========================= UI Config =========================
    
    func configSubviews() {
        // tableview
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(ZLYNewsCell.self, forCellReuseIdentifier: ZLYNewsCell.identifier)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: ZLYCycleScrollView.identifier)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        self.configRefreshUI()
        self.refreshTableView()
        
        // nav bar
        self.view.addSubview(self.fakeNavBar)
        self.fakeNavBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.fakeNavBar.height)
        }
        self.fakeNavBar.title = "今日新闻"
    }
    
    func refreshTableView() {
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        self.tableView.reloadData()
    }
    
    func configRefreshUI() {
        // 添加下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.refreshData()
        })
        // 添加上拉
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.fetchMoreData()
        })
    }
}
