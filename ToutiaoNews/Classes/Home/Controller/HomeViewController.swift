//
//  HomeViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/6.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import VTMagic
import RxSwift

class HomeViewController: UIViewController{
	
	var menuList = [String]()
	
	var newsTitles = [HomeNewsTitle]();
	
	/// 懒加载dispose
	lazy var disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupUI()
		self.selectAllTitleData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
	}
	
	/// 自定义导航栏
//	private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
	
	lazy var navigationBar : HomeNavigationView = {
		var navBar = HomeNavigationView.loadViewFromNib()
		navBar.didSelectAvatarButton = {
			sender in
			print("navigationBar avatar")
		}
		
		navBar.didSelectCameraButton = {
			sender in
			print("navigationBar camera")
		}
		
		navBar.didSelectSearchButton = {
			sender in
			print("navigationBar search")
		}
		
		return navBar
	}()
	
	private lazy var magicVC: VTMagicController = {
		let magicVC = VTMagicController()
		magicVC.magicView.navigationColor = .white
		magicVC.magicView.sliderColor = .red
		magicVC.magicView.switchStyle = .default
		magicVC.magicView.navigationHeight = newsTitleHeight
//		magicVC.magicView.frame = CGRect(x: 0, y: 64, width: self.view.bounds.width, height: self.view.height - 64)
		magicVC.magicView.rightNavigatoinItem = self.addChnnelButton
//		magicVC.magicView.headerHeight = 64.0
//		magicVC.magicView.rightNavigatoinItem
		magicVC.magicView.dataSource = self
		magicVC.magicView.delegate = self
		return magicVC
	}()
	
	lazy var addChnnelButton: UIButton = {
		let button = UIButton(type: UIButton.ButtonType.custom)
		button.frame = CGRect(x: 0, y: 0, width:newsTitleHeight , height: newsTitleHeight)
		button.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
		
		button.rx.controlEvent(.touchUpInside)
			.subscribe(onNext: { [weak self] in
				
			let homeAddCategoryVC = HomeAddCategoryController()
				
//			homeAddCategoryVC.modalSize = cgs
			self!.present(homeAddCategoryVC, animated: true, completion: nil)
		})
		.disposed(by: disposeBag)
		
		
		return button
	}()

}

// MARK: - 初始化UI布局与按钮点击事件
extension HomeViewController {
	
	// 设置UI布局
	private func setupUI() {
		
		self.navigationItem.titleView = self.navigationBar
		
		print("HomeViewController ->setupUI")
		self.addChild(self.magicVC)
		self.view.addSubview(self.magicVC.magicView)
		self.magicVC.magicView.reloadData()
		
		
		NetworkTool.loadHomeNewsTitleData { (Titles) in
			self.newsTitles = Titles;
			// 向数据库中插入数据
			NewsTitleTable().insert(titles: Titles)
			
			self.menuList.removeAll()
			_ = Titles.compactMap({ (newsTitle) -> () in
				self.menuList.append(newsTitle.name)
			})
			print("获取到的menuList = \(self.menuList)")
			self.magicVC.magicView.reloadData()
			
		}
		
	}
	
	/// 获取缓存数据
	func selectAllTitleData() -> () {
		self.menuList.removeAll()
		let newsTitles = NewsTitleTable().selectAll()
		self.newsTitles = newsTitles // 设置全局变量
		_ = newsTitles.map { (newsTitle) in
			self.menuList.append(newsTitle.name)
		}
		self.magicVC.magicView.reloadData()
		
	}

}


// MARK: - 分页控制器VTMagic的代理方法
extension HomeViewController: VTMagicViewDataSource,VTMagicViewDelegate {
	func menuTitles(for magicView: VTMagicView) -> [String] {
		return self.menuList
	}
	
	func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
		var menuItem = magicView.dequeueReusableItem(withIdentifier: "itemIden")
		if !(menuItem != nil) {
			menuItem = UIButton(type: .custom)
			menuItem?.setTitleColor(UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1), for: .normal)
			menuItem?.setTitleColor(UIColor(red: 169/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1), for: .selected)
//			menuItem?.titleLabel?.font
		}
		return menuItem!
	}
	
	func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
		let index = Int(pageIndex);
		let aNews = self.newsTitles[index]
		if aNews.category == .essayJoke { // 段子
			let jokeVC:HomeJokeViewController = magicView.dequeueReusablePage(withIdentifier: "essayJoke") as? HomeJokeViewController ?? HomeJokeViewController()
//			if jokeVC == nil {
//				jokeVC = HomeJokeViewController()
//			}
			jokeVC.setupRefresh(with:.essayJoke)
			return jokeVC
		} else if aNews.category == .imagePPMM { // 街拍
			let jokeVC:HomeJokeViewController = magicView.dequeueReusablePage(withIdentifier: "imagePPMM") as? HomeJokeViewController ?? HomeJokeViewController()
			//			if jokeVC == nil {
			//				jokeVC = HomeJokeViewController()
			//			}
			jokeVC.setupRefresh(with:.imagePPMM)
			return jokeVC
		} else if aNews.category == .imageFunny { // 趣图
			let jokeVC:HomeJokeViewController = magicView.dequeueReusablePage(withIdentifier: "imageFunny") as? HomeJokeViewController ?? HomeJokeViewController()
			//			if jokeVC == nil {
			//				jokeVC = HomeJokeViewController()
			//			}
			jokeVC.setupRefresh(with:.imageFunny)
			return jokeVC
		} else if aNews.category == .photos { // 组图
			let homeImageVC:HomeImageViewController = magicView.dequeueReusablePage(withIdentifier: "photos") as? HomeImageViewController ?? HomeImageViewController()
			homeImageVC.setupRefresh(with:.imageFunny)
			return homeImageVC
		}   else  {
			let recomentVC = magicView.dequeueReusablePage(withIdentifier: "recomentVC") as? HomeRecommendController ?? HomeRecommendController()
			recomentVC.setupRefresh(with: aNews.category)
			return recomentVC
//			var imageVC = magicView.dequeueReusablePage(withIdentifier: "imageVC")
//			if imageVC == nil {
//				imageVC = HomeImageViewController()
//			}
//			return imageVC!
		}
	}
}
