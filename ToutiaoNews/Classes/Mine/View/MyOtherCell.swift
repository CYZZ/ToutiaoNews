//
//  MyOtherCell.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/10.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell,RegisterCellFromNib {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detaillabel: UILabel!
	
	@IBOutlet weak var separatorView: UIView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
