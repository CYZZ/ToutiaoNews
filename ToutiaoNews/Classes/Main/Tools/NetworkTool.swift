//
//  NetworkTool.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/11.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkToolProtocol {
	// MARK: 我的界面cell的数据
	static func loadMyCellData(completionHandler:@escaping(_ sections:[[MyCellModel]])->())
	// MARK: 我的关注数据
	static func loadMyConcern(completionHandler:@escaping(_ concerns:[MyConcern])->())
	// MARK: 获取用户详情
	static func loadUserDetail(userId:Int,completionHandler:@escaping(_ userDetail:UserDetail)->())
}

extension NetworkToolProtocol {
	// MARK: 我的 mine----------
	static func loadMyCellData(completionHandler: @escaping ([[MyCellModel]]) -> ()) {
		let url = BASE_URL + "/user/tab/tabs/?"
		let params  = ["device_id":device_id]
		
		Alamofire.request(url, method: .get, parameters: params, encoding:URLEncoding.default , headers: nil).responseJSON { (response) in
			
			guard response.result.isSuccess else {
				return
			}
			
			if let value = response.result.value {
				let json = JSON(value)
				guard json["message"] == "success" else {
					return
				}
				
				var mySections  = [[MyCellModel]]()
				mySections.append([MyCellModel.deserialize(from: "{\"text\":\"我的关注\",\"grey_text\":\"\"}")!])
				if let data = json["data"].dictionary {
					if let sections = data["sections"]?.arrayObject {
						mySections += sections.compactMap({ (item) in
							(item as![Any]).compactMap({
								MyCellModel.deserialize(from: $0 as? Dictionary)
							})
						})
						completionHandler(mySections)
					}
				}
				
			}
		}
	}
	
	static func loadMyConcern(completionHandler: @escaping ([MyConcern]) -> ()) {
		
	}
	
	static func loadUserDetail(userId: Int, completionHandler: @escaping (UserDetail) -> ()) {
		
	}
}

struct NetworkTool: NetworkToolProtocol {
	
}
