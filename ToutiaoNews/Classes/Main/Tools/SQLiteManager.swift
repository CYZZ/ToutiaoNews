//
//  SQLiteManager.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/13.
//  Copyright © 2019 chiyz. All rights reserved.
//

import UIKit
import SQLite

struct  SQLiteManager {
	// 数据库链接
	var database:Connection!
	
	init() {
		do {
			let path = NSHomeDirectory() + "/Documents/news.sqlite3"
			database = try Connection(path)
			
		} catch  {
			print(error)
		}
	}
	
}

/// 缓存首页新闻数据
struct NewsTitleTable {
	private let sqlManager = SQLiteManager()
	/// 新闻标题 表
	private let news_title = Table("news_title")
	/// 表字段
	let id  = Expression<Int64>("id")
	let category = Expression<String>("category")
	let tip_new = Expression<Int64>("tip_new")
	let default_add = Expression<Int64>("default_add")
	let web_url = Expression<String>("web_url")
	let concern_id = Expression<String>("concern_id")
	let icon_url = Expression<String>("icon_url")
	let flags = Expression<Int64>("flags")
	let type = Expression<Int64>("type")
	let name = Expression<String>("name")
	let selected = Expression<Bool>("selected")
	
	init() {
		// 建表
		try! sqlManager.database.run(news_title.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
			t.column(id, primaryKey: true)
			t.column(category)
			t.column(tip_new)
			t.column(default_add)
			t.column(web_url)
			t.column(concern_id)
			t.column(icon_url)
			t.column(flags)
			t.column(type)
			t.column(name)
			t.column(selected)
		}))
	}
	
	/// 插入一组数据
	func insert(titles:[HomeNewsTitle]) {
		_ = titles.map { (newsTitle) in
			insert(title:newsTitle)
		}
	}
	/// 插入一条数据
	func insert(title:HomeNewsTitle ) {
		/// 如果数据不在表里面
		if !(exist(title)) {
			let insert = news_title.insert(category <- title.category.rawValue,
										   tip_new <- Int64(title.tip_new),
										   default_add <- Int64(title.default_add),
										   concern_id <- title.concern_id,
										   web_url <- title.web_url,
										   icon_url <- title.icon_url,
										   flags <- Int64(title.flags),
										   type <- Int64(title.type),
										   name <- title.name,
										   selected <- title.selected )
			
			try! sqlManager.database.run(insert)
		}
	}
	
	/// 判断是否在表里面
	func exist(_ title:HomeNewsTitle) -> Bool {
		// 取出该新闻分类的数据
		let title = news_title.filter(category == title.category.rawValue)
		// 判断数据是否存在可以根据count是否为 0 来判断这条数据 0 没有 1 存在
		let count = try! sqlManager.database.scalar(title.count)
		return count != 0
		
	}
	
	/// 查询所有数据
	func selectAll() -> [HomeNewsTitle] {
		var allTitles = [HomeNewsTitle]()
		// 遍历c表中数据
		for title in try! sqlManager.database.prepare(news_title) {
			// 取出表中数据，并初始化一个结构体模型
			let newsTitle = HomeNewsTitle(category:NewsTitleCategory(rawValue: title[category])!,
										  tip_new:Int(title[tip_new]),
										  default_add:Int(title[default_add]),
										  web_url:title[web_url],
										  concern_id:title[concern_id],
										  icon_url:title[icon_url],
										  flags:Int(title[flags]),
										  type:Int(title[type]),
										  name:title[name],
										  selected:title[selected]
										  )
			// 添加到数组总
			allTitles.append(newsTitle)
			
		}
		return allTitles
		
		// 不再使用 map 方式
		//        let newsTitles = try! sqlManager.database.prepare(news_title)
		//        return newsTitles.map({ title in
		//            // 取出表中数据，并初始化为一个结构体模型
		//            HomeNewsTitle(category: title[category], tip_new: Int(title[tip_new]), default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])
		//        })
		
	}
	
	// 更新数据
	func update(_ newsTitle:HomeNewsTitle) -> Void {
		// 取出数据库中的数据
		let title = news_title.filter(category == newsTitle.category.rawValue)
		// 更新数据
		try! sqlManager.database.run(title.update(selected <- newsTitle.selected))
	}
}
