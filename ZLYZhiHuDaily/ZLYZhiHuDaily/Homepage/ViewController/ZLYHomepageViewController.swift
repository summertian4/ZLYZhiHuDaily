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
    
    private var tableview: UITableView = UITableView(frame: CGRect(), style: UITableViewStyle.grouped)
    private var news: Array<Array<ZLYNews>> = Array<Array<ZLYNews>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    private func fetchData() {
        ZLYNewsService.fetchLastNews(success: { (lastNews) in
            print("\(lastNews)")
            if let stories = lastNews?.stories {
                self.news.append(stories)
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
        self.tableview.register(ZLYNewsCell.self, forCellReuseIdentifier: ZLYNewsCell.identifier)
        self.tableview.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.bottom.equalTo(self.view)
        }
        self.tableview.reloadData()
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ZLYNewsCell.identifier, for: indexPath) as! ZLYNewsCell
        cell.model = self.news[indexPath.section][indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
