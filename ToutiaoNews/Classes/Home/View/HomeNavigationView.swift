//
//  HomeNavigationView.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNavigationView: UIView,NibLoadable {

	@IBOutlet weak var avatarButton: UIButton!
	
	@IBOutlet weak var searchButton: AnimatableButton!
	@IBOutlet weak var camaraButton: UIButton!
	
	/// 搜索按钮点击回调
	var didSelectSearchButton:((_ sender:AnimatableButton)->())?
	var didSelectAvatarButton:((_ sender:UIButton)->())?
	var didSelectCameraButton:((_ sender:UIButton)->())?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		NetworkTool.loadHomeSearchSuggestInfo { (suggest) in
			self.searchButton.setTitle(suggest, for: .normal)
		}
	}
	
	override var intrinsicContentSize: CGSize {
		return UIView.layoutFittingExpandedSize
	}
	
	/// 重写frame
	override var frame: CGRect {
		didSet {
			super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
		}
	}
	
	
	@IBAction func avatarClick(_ sender: UIButton) {
		didSelectAvatarButton?(sender)
	}
	
	@IBAction func searchClick(_ sender: AnimatableButton) {
		didSelectSearchButton?(sender)
	}
	
	@IBAction func camaraClick(_ sender: UIButton) {
		didSelectCameraButton?(sender)
	}
	
}
