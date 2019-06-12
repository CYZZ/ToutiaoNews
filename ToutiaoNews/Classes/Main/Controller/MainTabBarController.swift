//
//  MainTabBarController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/6.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tabbar = UITabBar.appearance()
		tabbar.theme_tintColor = "colors.tabbarTintColor"
		tabbar.theme_barTintColor = "colors.cellBackgroundColor"
		
		addChildViewControllers()
		
		NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClick(_:)), name: Notification.Name(rawValue: ChangeDayOrNight), object: nil)
		
	}
	
	@objc func receiveDayOrNightButtonClick(_ notification:Notification) {
		print("收到了切换页面模式的通知\(self)")
	}
	
	/// 添加子控制器
	private func addChildViewControllers() {
		setChildViewController(HomeViewController(), title: "首页", imageName: "home")
		setChildViewController(VideoViewController(), title: "西瓜视频", imageName: "video")
		setChildViewController(RedPackageViewController(), title: "", imageName: "redpackage")
		setChildViewController(WeitoutiaoViewController(), title: "微头条", imageName: "weitoutiao")
//		setChildViewController(HuoshanViewController(), title: "小视频", imageName: "huoshan")
		setChildViewController(MineViewController(), title: "我的", imageName: "huoshan")
	}
	
	/// 初始化单个子控制器
	func setChildViewController(_ childController:UIViewController,title:String, imageName:String) {
		
		// 设置 控制器对应的 tabbar
		if UserDefaults.standard.bool(forKey: isNight) {
			setNightChildController(controller: childController, imageName: imageName)
		} else {
			setDayChildController(controller: childController, imageName: imageName)
		}
		
		childController.title = title
		addChild(MyNavigationController(rootViewController: childController))
	}
	
	// 设置夜间的控制器样式
	func setNightChildController(controller:UIViewController,imageName:String) {
		controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
		controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
	}
	
	// 设置日间的控制器样式
	func setDayChildController(controller:UIViewController,imageName:String) {
		controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
		controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
	}

}
