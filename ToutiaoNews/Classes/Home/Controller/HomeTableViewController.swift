//
//  HomeTableViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import SVProgressHUD
import BMPlayer
import MJRefresh

///# 作为首页的其他控制器的列表控制器基类
class HomeTableViewController: UITableViewController {
	
	/// 懒加载播放器
	lazy var player:BMPlayer = BMPlayer(customControlView: VideoPlayerCustomView())
	/// 标题
	var newsTitle = HomeNewsTitle()
	/// 新闻数据
	var news  = [NewsModel]()
	/// 刷新时间
	var maxBehotTime: TimeInterval = 0.0
	
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

		SVProgressHUD.configuration()
		tableView.tableFooterView = UIView()
		
		
		
    }
	
	func setupRefresh(with category: NewsTitleCategory = .recommend) {
		// 下拉刷新
		let header = RefreshHeader {
			[weak self] in
			NetworkTool.loadApiNewsFeeds(category: category, ttFrom: .pull, {
				(timeInterval, newsModels) in
				if self?.tableView.mj_header.isRefreshing == true {
					self?.tableView.mj_header.endRefreshing()
				}
				self?.player.removeFromSuperview()
				self?.maxBehotTime = timeInterval
				self?.news = newsModels
				self?.tableView.reloadData()
			})
		}
		header?.isAutomaticallyChangeAlpha = true
		header?.lastUpdatedTimeLabel.isHidden = true
		tableView.mj_header = header
		tableView.mj_header.beginRefreshing()
		
		// 上拉刷新控件
		let footer = RefreshAutoGifFooter {
			[weak self] in
			// 上拉加载更多
			NetworkTool.loadMoreApiNewsFeeds(category: category, ttFrom: .loadMore, maxBehotTime: self!.maxBehotTime, listCount: self!.news.count , {
				(models) in
				if self?.tableView.mj_footer.isRefreshing == true {
					self?.tableView.mj_footer.endRefreshing()
				}
				self?.tableView.mj_footer.pullingPercent = 0.0
				self?.player.removeFromSuperview()
				if models.count == 0 {
					SVProgressHUD.showInfo(withStatus: "没有更多数据了！")
					return
				}
				self?.news += models
				self?.tableView.reloadData()
			})
		}
		
		footer?.isAutomaticallyChangeAlpha = true
		tableView.mj_footer = footer
	}
	
	

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }


}
