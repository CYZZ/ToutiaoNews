//
//  NoLoginHeaderView.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/6.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

class NoLoginHeaderView: UIView,NibLoadable {

	@IBOutlet weak var bgImageView: UIImageView!
	
	@IBOutlet weak var wechatButton: UIButton!
	@IBOutlet weak var mobileButton: UIButton!
	@IBOutlet weak var qqButton: UIButton!
	@IBOutlet weak var sinaButton: UIButton!
	@IBOutlet weak var moreLoginButton: AnimatableButton!
	
	@IBOutlet weak var favoriteButton: UIButton!
	@IBOutlet weak var historyButton: UIButton!
	@IBOutlet weak var nightButton: UIButton!
	@IBOutlet weak var statckView: UIStackView!
	@IBOutlet weak var bottomView: UIView!
	
	var dayOrNightChange:( _ sender:UIButton) -> Void = {
		_ in
	}
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		nightButton.isSelected = UserDefaults.standard.bool(forKey: isNight)
		nightButton.setTitle("夜间", for: .normal)
		nightButton.setTitle("日间", for: .selected)
		
		let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
		effectX.maximumRelativeValue = 20
		effectX.minimumRelativeValue = -20
		statckView.addMotionEffect(effectX)
		
//		需要在这里设置日间和夜间的图片
		
	}
	
	
	@IBAction func dayOrNightClick(_ sender: UIButton) {
		dayOrNightChange(sender)
	}
}
