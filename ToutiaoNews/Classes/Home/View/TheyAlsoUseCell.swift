//
//  TheyAlsoUseCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/18.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell,RegisterCellFromNib {
	
	
	var theyUse = SmallVideo() {
		didSet {
			leftLabel.text = theyUse.title
			rightButton.setTitle(theyUse.show_more, for: .normal)
			userCards = theyUse.user_cards
			collectionView.reloadData()
		}
	}
	
	var userCards = [UserCard]()
	
	

	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var rightButton: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	override func awakeFromNib() {
        super.awakeFromNib()
		
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 10, right: 10)
		layout.scrollDirection = .horizontal
		collectionView.collectionViewLayout = layout
		collectionView.delegate = self;
		collectionView.dataSource = self
		collectionView.yz_registerCell(cell: TheyUseCollectionCell.self )
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TheyAlsoUseCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return userCards.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.yz_dequeueReusableCell(indexPath: indexPath) as TheyUseCollectionCell
		cell.userCard = userCards[indexPath.item]
		
		return cell
	}
	
}
