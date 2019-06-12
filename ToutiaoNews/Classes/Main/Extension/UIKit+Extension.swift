//
//  UIKit+Extension.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/10.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import Foundation
import UIKit
import CoreText

protocol StoryboradLoadable {
	
}
extension StoryboradLoadable where Self:UIViewController {
	///提供加载方法
	static func loadStoryborad() -> Self {
		return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
	}
}

protocol NibLoadable {
	
}
extension NibLoadable {
	static func loadViewFromNib() -> Self {
		return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
	}
}


extension UIView {
	
	var x: CGFloat {
		get {
			return frame.origin.x
		}
		set {
			var tempFrame = frame
			tempFrame.origin.x = newValue
			frame = tempFrame
		}
	}
	
	var y: CGFloat {
		get {
			return frame.origin.y
		}
		set {
			var tempFrame = frame
			tempFrame.origin.y = newValue
			frame = tempFrame
		}
	}
	
	var height: CGFloat {
		get {
			return frame.size.height
		}
		set {
			var tempFrame = frame
			tempFrame.size.height = newValue
			frame = tempFrame
		}
	}
	
	var width: CGFloat {
		get {
			return frame.size.width
		}
		set {
			var tempFrame = frame
			tempFrame.size.width = newValue
			frame = tempFrame
		}
	}
	
	var size: CGSize {
		get {
			return frame.size
		}
		set {
			var tempFrame = frame
			tempFrame.size = newValue
			frame = tempFrame
		}
	}
	
	var centerX: CGFloat {
		get {
			return center.x
		}
		set {
			var tempCenter = center
			tempCenter.x  = newValue
			center = tempCenter
		}
	}
	
	var centerY: CGFloat {
		get {
			return center.y
		}
		set {
			var tempCenter = center
			tempCenter.y = newValue
			center = tempCenter
		}
	}
	
}

protocol RegisterCellFromNib {
	
}

extension RegisterCellFromNib {
	static var identifier:String{
		return "\(self)"
	}
	
	static var nib:UINib?{
		return UINib(nibName: "\(self)", bundle: nil)
	}
	
}


extension UITableView {
	/// 注册cell的方法
	func yz_registerCell<T:UITableViewCell>(cell:T.Type) where T:RegisterCellFromNib {
		if let nib = T.nib {
			register(nib, forCellReuseIdentifier: T.identifier)
		} else {
			register(cell, forCellReuseIdentifier: T.identifier)
		}
	}
	
	/// 从缓存池中获取cell
	func yz_dequeueReusableCell<T:UITableViewCell>(indexPath:IndexPath) -> T where T:RegisterCellFromNib {
		return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
	}
}

extension UICollectionView {
	
	/// 注册cell的方法
	func yz_registerCell<T:UICollectionViewCell>(cell:T.Type) where T:RegisterCellFromNib   {
		if let nib = T.nib {
			register(nib, forCellWithReuseIdentifier: T.identifier)
		}else {
			register(cell, forCellWithReuseIdentifier: T.identifier)
		}
	}
	
	/// 从缓存池中获取cell
	func yz_dequeueReusableCell<T>(indexPath:IndexPath) -> T where T:UICollectionViewCell, T:RegisterCellFromNib {
			return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
	}
	
	/// 注册头部
	func yz_registerSupplementaryHeaderView<T:UICollectionReusableView>(reusableView:T.Type) where T:RegisterCellFromNib {
		if let nib = T.nib {
			register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
		} else {
			register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
		}
	}
	
	/// 获取可重用的头部
	func yz_dequeueReusableSupplementaryHeaderView<T:UICollectionReusableView>(indexPath:IndexPath) -> T where T: RegisterCellFromNib {
		return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
	}
}
