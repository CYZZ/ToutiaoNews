//
//  HomeRecommendController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
///# 问答
class HomeRecommendController: HomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		tableView.yz_registerCell(cell: HomeUserCell.self )
		tableView.yz_registerCell(cell: TheyAlsoUseCell.self )
		tableView.yz_registerCell(cell: HomeCell.self)
    }
	

}

extension HomeRecommendController {
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let aNews = news[indexPath.row]
		
		switch aNews.cell_type {
		case .user:
			return aNews.contentH
		case .relatedConcern:
			return 290
		case .none:
			return aNews.cellHeight
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return news.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let aNews = news[indexPath.row]
		
		switch aNews.cell_type {
		case .user:
			let cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as HomeUserCell
			cell.aNews = aNews
			return cell
		case .relatedConcern:
			let  cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as TheyAlsoUseCell
			cell.theyUse = aNews.raw_data
			return cell
		case .none:
			let cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as HomeCell
			cell.aNews = aNews
			return cell
		}
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}
