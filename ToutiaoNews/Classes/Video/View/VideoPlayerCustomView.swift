//
//  VideoPlayerCustomView.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import BMPlayer
import SnapKit

class VideoPlayerCustomView: BMPlayerControlView {

	override func customizeUIComponents() {
		BMPlayerConf.topBarShowInCase  = .none
	}
}
