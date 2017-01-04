//
//  ZLYHomepageViewController+ZLYDelage.swift
//  ZLYZhiHuDaily
//
//  Created by 周凌宇 on 2016/12/30.
//  Copyright © 2016年 微鲸科技. All rights reserved.
//

import Foundation

extension ZLYHomepageViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: - ========================= UITableViewDataSource & UITableViewDelegate =========================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dailyNews?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.dailyNews?[section].stories?.count {
            if section == 0 {
                return count + 1
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ZLYCycleScrollView.identifier, for: indexPath)
                let cycleScrollView = cell.viewWithTag(7878)
                if cycleScrollView == nil {
                    cell.addSubview(self.cycleScrollView)
                    self.cycleScrollView.tag = 7878
                    self.cycleScrollView.snp.makeConstraints({ (make) in
                        make.edges.equalTo(cell)
                    })
                }
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: ZLYNewsCell.identifier, for: indexPath) as! ZLYNewsCell
            if let model = self.dailyNews?[indexPath.section].stories?[indexPath.row - 1] {
                cell.model = model
            }
            return cell;
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ZLYNewsCell.identifier, for: indexPath) as! ZLYNewsCell
        if let model = self.dailyNews?[indexPath.section].stories?[indexPath.row] {
            cell.model = model
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 0
        }
        return self.tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0) {
            return nil
        }
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: ZLYGlobalTool.screenWidth, height: self.tableHeaderHeight)
        headerView.backgroundColor = ZLYGlobalTool.themeColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: ZLYGlobalTool.screenWidth, height: self.tableHeaderHeight))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 16)
        
        if let dateStr = self.dailyNews?[section].date {
            let string = Date.date(fromyyyyMMMMdd: dateStr)?.MMMM月dd日EEEE
            label.text = string
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return self.cycleScrollView.height
        }
        return 120
    }
    
    // MARK: - ========================= UIScrollViewDelegate =========================
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var alpha: CGFloat = 0
        let offsetY = self.tableView.contentOffset.y
        if offsetY < 0 {
            self.fakeNavBar.mode = ZLYFakeNavBar.Mode.Translucence(alpha: 0.0)
            return
        }
        
        if offsetY >= self.cycleScrollView.height {
            self.fakeNavBar.mode = ZLYFakeNavBar.Mode.Translucence(alpha: 1.0)
        }
        
        if let count = self.dailyNews?.first?.stories?.count {
            let changPointY = self.cycleScrollView.height + CGFloat(count * 120)
            if offsetY >= changPointY {
                self.fakeNavBar.mode = ZLYFakeNavBar.Mode.OnlyStatusBar
                return
            }
        }
        
        alpha = CGFloat(fabsf(Float(offsetY)) / Float(self.cycleScrollView.height))
        self.fakeNavBar.mode = ZLYFakeNavBar.Mode.Translucence(alpha: alpha)
    }
}
