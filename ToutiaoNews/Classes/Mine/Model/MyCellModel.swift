//
//  MyCellModel.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/6.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import HandyJSON

struct MyCellModel: HandyJSON {
	var grey_text: String = ""
	var text: String = ""
	var url: String = ""
	var key: String = ""
	var tip_new: Int = 0
}

struct MyConcern: HandyJSON {
	var name: String = ""
	var url: String = ""
	var description: String = ""
	var time: String = ""
	var type: String = ""
	var icon:String = ""
	var is_verify:Bool = false
	var media_id:Int = 0
	var tips:Bool = false
	var user_auth_info = UserAuthInfo()
	
}

struct UserAuthInfo:HandyJSON {
	var auth_type:Int = 0
	var auth_info:String = ""
	
	
}
