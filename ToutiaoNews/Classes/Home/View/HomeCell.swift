//
//  HomeCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/18.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell,RegisterCellFromNib {
	
	var aNews  = NewsModel() {
		didSet {
			mainTItleLabel.text = aNews.title
			concentLabel.text = (aNews.comment_count == 0 ? "" : aNews.commentCount + "评论")
			if aNews.media_name != "" {
				usernameLabel.text = aNews.media_name
			} else if aNews.media_info.media_id != 0 {
				usernameLabel.text = aNews.media_info.name
			} else if aNews.user_info.user_id != 0 {
				usernameLabel.text = aNews.user_info.name
			}
			timeLabel.text = aNews.publishTime
		}
	}
	

	@IBOutlet weak var mainTItleLabel: UILabel!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var concentLabel: UILabel!
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
