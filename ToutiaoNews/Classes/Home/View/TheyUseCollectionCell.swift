//
//  TheyUseCollectionCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/18.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import Kingfisher
import IBAnimatable

class TheyUseCollectionCell: UICollectionViewCell,RegisterCellFromNib {
	
	var userCard  = UserCard() {
		didSet {
			avartImageView.kf.setImage(with: URL(string: userCard.user.info.avatar_url)!)
			nameLabel.text = userCard.user.info.name
			subLabel.text = userCard.recommend_reason
			vipImageView.isHidden = userCard.user.info.user_auth_info.auth_info == ""
		}
	}
	
	
	@IBOutlet weak var avartImageView: UIImageView!
	
	@IBOutlet weak var vipImageView: UIImageView!
	
	@IBOutlet weak var loadinImageView: UIImageView!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var subLabel: UILabel!
	@IBOutlet weak var concentButton: AnimatableButton!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		layer.cornerRadius = 5
		layer.masksToBounds = true
//		layer.borderColor = "colors.lightGray"
		layer.borderWidth = 1
		concentButton.setTitle("关注", for: .normal)
		concentButton.setTitle("已关注", for: .selected)
    }
	
	@IBAction func concentClick(_ sender: AnimatableButton) {
		loadinImageView.isHidden = false
		loadinImageView.layer.add(animation, forKey: nil)
		
		if sender.isSelected {
			// 已关注，点击取消关注
			NetworkTool.loadRelationUnfollow(userId: userCard.user.info.user_id) { (cernUser) in
				sender.isSelected = !sender.isSelected
				self.loadinImageView.isHidden = true
				sender.borderWidth = 0
			}
		} else {
			// 未关注点击，关注该用户
			NetworkTool.loadRelationFollow(userId: userCard.user.info.user_id) { (_) in
				sender.isSelected = !sender.isSelected
				self.loadinImageView.layer.removeAllAnimations()
				self.loadinImageView.isHidden = true
				sender.borderColor = .grayColor232()
				sender.borderWidth = 1
			}
		}
		
	}
	
	lazy var animation: CABasicAnimation = {
		let animation = CABasicAnimation(keyPath: "transform.rotation.z")
		animation.fromValue = 0.0
		animation.toValue = Double.pi * 2
		animation.duration = 1.5
		animation.autoreverses = false
		animation.repeatCount = MAXFLOAT
		return animation
	}()
	
}
