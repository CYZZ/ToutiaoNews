//
//  HomeImageViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit

class HomeImageViewController: HomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.lightGray
		
		self.tableView.yz_registerCell(cell: HomeImageTableCell.self)
    }
}

extension HomeTableViewController {
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return news[indexPath.row].imageCellHeight
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return news.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as HomeImageTableCell
		cell.homeImage = news[indexPath.row]
		return cell
		
	}
}
