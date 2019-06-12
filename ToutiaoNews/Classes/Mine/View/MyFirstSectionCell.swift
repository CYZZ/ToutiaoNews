//
//  MyFirstSectionCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/10.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit

class MyFirstSectionCell: UITableViewCell,RegisterCellFromNib {

	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var rightImageView: UIImageView!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var topView: UIView!
	
	var myCellModel = MyCellModel() {
		didSet {
			leftLabel.text = myCellModel.text
		}
	}
	
	
	var myConcerns = [MyConcern]() {
		didSet {
			collectionView.reloadData()
		}
	}
	
	var myConcern = MyConcern() {
		didSet {
			
		}
	}
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		collectionView.collectionViewLayout = MyConcernFlowLayout()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.yz_registerCell(cell: MyConcernCell.self)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyFirstSectionCell : UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myConcerns.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.yz_dequeueReusableCell(indexPath: indexPath) as MyConcernCell
		
		cell.myConcern = myConcerns[indexPath.item]
		return cell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
	override func prepare() {
		// 设置每个cell的大小
		itemSize = CGSize(width: 58, height: 74)
		// 间距
		minimumLineSpacing = 0
		minimumInteritemSpacing = 0
		
		sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
		scrollDirection = .horizontal
	}
}
