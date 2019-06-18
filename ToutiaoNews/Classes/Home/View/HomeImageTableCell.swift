//
//  HomeImageTableCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/14.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import Kingfisher

class HomeImageTableCell: UITableViewCell,RegisterCellFromNib {
	
	var homeImage = NewsModel() {
		didSet {
			if homeImage.gallary_image_count > 0 {
				imageCountLabel.text = "\(homeImage.gallary_image_count)图"
			}
			imageTitleLabel.text = homeImage.title
			timeLabel.text = homeImage.commentCount + "评论"
			if homeImage.media_info.user_id != 0 {
				usernameLabel.text = homeImage.media_info.name
			}
			
			if let firstImage = homeImage.image_list.first {
				mainImageView.kf.setImage(with: URL(string: firstImage.urlString))
			}
		}
	}
	

	@IBOutlet weak var imageTitleLabel: UILabel!
	@IBOutlet weak var mainImageView: UIImageView!
	
	@IBOutlet weak var usernameLabel: UILabel!
	
	@IBOutlet weak var imageCountLabel: UILabel!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var timeLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
