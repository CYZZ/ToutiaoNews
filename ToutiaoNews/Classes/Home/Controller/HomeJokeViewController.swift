//
//  HomeJokeViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit

class HomeJokeViewController: HomeTableViewController {
	/// 判断是否段子
	var isJoke = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .orange
		
		tableView.yz_registerCell(cell: HomeJokeCell.self)
    }
}

extension HomeJokeViewController {
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let aNews = news[indexPath.row]
		return isJoke ? aNews.jokeCellHeight : aNews.girlCellHeight
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return news.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as HomeJokeCell
		cell.isJoke = isJoke
		cell.joke = news[indexPath.row]
		return cell
		
	}
}
