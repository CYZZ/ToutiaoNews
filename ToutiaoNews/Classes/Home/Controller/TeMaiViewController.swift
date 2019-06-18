//
//  TeMaiViewController.swift
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/12.
//  Copyright © 2019年 chiyz. All rights reserved.
//

import UIKit
import WebKit

class TeMaiViewController: UIViewController {
	
	var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
		let webView = WKWebView(frame: view.bounds, configuration: WKWebViewConfiguration())
		webView.load(URLRequest(url: URL(string: url)!))
		view.addSubview(webView)
		
        // Do any additional setup after loading the view.
    }
    


}
