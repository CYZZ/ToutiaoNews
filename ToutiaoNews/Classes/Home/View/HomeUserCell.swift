//
//  HomeUserCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/18.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import Kingfisher

class HomeUserCell: UITableViewCell,RegisterCellFromNib {
	
	var aNews  = NewsModel() {
		didSet {
			// 发布者
			if aNews.source != "" {
				nameLabel.text = aNews.source
			} else if aNews.user_info.user_id != 0 {
				avatarImageView.kf.setImage(with:URL(string:aNews.user_info.avatar_url)!)
				nameLabel.text = aNews.user.screen_name
			} else if aNews.media_info.user_id != 0 {
				nameLabel.text = aNews.media_info.name
				avatarImageView.kf.setImage(with: URL(string: aNews.media_info.avatar_url)!)
			}
			readCountLabel.text = "\(aNews.readCount)阅读"
			verifiedLabel.text = aNews.verified_content
			digButton.setTitle(aNews.diggCount, for: .normal)
			commentButton.setTitle("\(aNews.commentCount)", for: .normal)
			feedShareButton.setTitle("\(aNews.forwardCount)", for: .normal)
			contentLabel.attributedText = aNews.attributedContent
		}
	}
	

	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var vipImageView: UIImageView!
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var verifiedLabel: UILabel!
	@IBOutlet weak var concernButton: UIButton!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var contentLabel: UILabel!
	
	@IBOutlet weak var readCountLabel: UILabel!
	
	@IBOutlet weak var digButton: UIButton!
	@IBOutlet weak var commentButton: UIButton!
	@IBOutlet weak var feedShareButton: UIButton!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
