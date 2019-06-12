//
//  MyConcernCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/10.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcernCell: UICollectionViewCell, RegisterCellFromNib {

	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var vipImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	var myConcern = MyConcern() {
		didSet {
			avatarImageView.kf.setImage(with: URL(string: myConcern.icon))
			nameLabel.text = myConcern.name
			vipImageView.image = myConcern.user_auth_info.auth_type == 1 ? UIImage(named: "all_v_avatar_star_16x16_") : UIImage(named: "all_v_avatar_18x18_")
		}
	}
	
	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		// 在这里初始化各个控件的样式
    }

}
