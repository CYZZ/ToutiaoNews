//
//  SVProgressHUD+Extension.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
	/// 初始化SVProgress的默认属性
	static func configuration() {
		SVProgressHUD.setForegroundColor(.white)
		SVProgressHUD.setMinimumDismissTimeInterval(1.5)
		SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
	}
}
