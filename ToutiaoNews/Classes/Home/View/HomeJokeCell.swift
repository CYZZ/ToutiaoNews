//
//  HomeJokeCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/14.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import Kingfisher

class HomeJokeCell: UITableViewCell, RegisterCellFromNib {
	
	var isJoke = false {
		didSet {
			jokeImageView.isHidden = isJoke
		}
	}
	
	var joke = NewsModel() {
		didSet {
			jokeLabel.text = joke.content
			commentButton.setTitle(joke.comment_count == 0 ? "评论":joke.commentCount, for: .normal)
			dislikeButton.setTitle(joke.buryCount, for: .normal)
			
			if joke.large_image.url.length != 0 {
				jokeImageView.kf.setImage(with: URL(string: joke.large_image.urlString))
			}
		}
	}
	
	

	@IBOutlet weak var likeButton: UIButton!
	@IBOutlet weak var dislikeButton: UIButton!
	@IBOutlet weak var commentButton: UIButton!
	@IBOutlet weak var starButton: UIButton!
	
	@IBOutlet weak var shareButton: UIButton!
	@IBOutlet weak var jokeLabel: UILabel!
	@IBOutlet weak var jokeImageView: UIImageView!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
