//
//  MineViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/6.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftTheme

class MineViewController: UIViewController {
	
	private let disposeBag = DisposeBag()
	// 存储cell的分组数据
	var sections = [[MyCellModel]]()
	// 存储我的关注的数据
	var concerns  = [MyConcern]()
	
	
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.addSubview(tableView)
		
		tableView.tableFooterView = UIView()
		tableView.yz_registerCell(cell: MyFirstSectionCell.self)
		tableView.yz_registerCell(cell: MyOtherCell.self)
		
		/// 获取数据
		NetworkTool.loadMyCellData {
			self.sections = $0
			self.tableView.reloadData()
			
			NetworkTool.loadMyConcern{_ in
//				self.concerns = $0
//				self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
			}
		}
		
//		let buttonTap = headerView.moreLoginButton.rx.tap
//		buttonTap.subscribe { (event) in
//			print("点击了更多按钮")
//		}.disposed(by: disposeBag)
		
		headerView.moreLoginButton.rx.tap
			.subscribe { (event) in
			print("点击了更多按钮")
			}.disposed(by: disposeBag)
		
		headerView.dayOrNightChange = {
			_ in
			print("在MinViewController中接收到了夜间模式点击")
//			NetworkTool.loadMyCellData(completionHandler: { (models) in
//				print("models = \(models)")
//			})
			NetworkTool.loadMyConcern(completionHandler: { (myconcenArr) in
				print("myConcenArr = \(myconcenArr)")
			})
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"+(UserDefaults.standard.bool(forKey: isNight) ? "_night":"")), for: .default)
	}
	
	lazy var headerView = NoLoginHeaderView.loadViewFromNib()
	
	private lazy var tableView:UITableView = {
		let tableView = UITableView(frame: self.view.bounds, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		
		tableView.tableHeaderView = headerView
//		tableView.theme_backgroundColor = ""
		
		return tableView
	}()

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

extension MineViewController: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 && indexPath.row == 0 {
			let cell:MyFirstSectionCell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell
			
			return cell
		}
		
		let cell = tableView.yz_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
		
		let myCellModel = sections[indexPath.section][indexPath.row]
		cell.titleLabel.text = myCellModel.text
		cell.detaillabel.text = myCellModel.grey_text
		return cell
		
		
	}
	
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return section == 1 ? 0 : 10
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 10))
//		view.them_backgroundColor = ""
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 && indexPath.row == 0 {
			return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
		}
		return 40
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("点击了 \(indexPath.section)->\(indexPath.row)")
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		// 在这里动态改变头部高度
	}
	
}
