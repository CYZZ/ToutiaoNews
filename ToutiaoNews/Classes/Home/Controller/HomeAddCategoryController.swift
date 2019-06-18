//
//  HomeAddCategoryController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeAddCategoryController: UIViewController,NibLoadable {
	
	// 是否编辑状态
	var isEdit = false {
		didSet {
			
		}
	}
	

	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	@IBAction func closeButtonClick(_ sender: UIButton) {
		self.dismiss(animated: true) {
			
		}
	}
	

}
