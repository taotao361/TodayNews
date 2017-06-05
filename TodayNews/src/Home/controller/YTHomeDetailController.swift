//
//  YTHomeDetailController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/5.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTHomeDetailController: YTBaseController {

    var newsTopic : YTNewsTopic?
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.tintColor = YMColor(210, g: 63, b: 66, a: 1.0)
//    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "new_more_titlebar_28x28_"), style: .plain, target: self, action: #selector(more))
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .default
        navigationItem.titleView = searchBar
        searchBar.placeholder = newsTopic?.source
        
        view.addSubview(webView)
        view.addSubview(bottomView)
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(SCREENH-45)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(SCREENH-45-49)
            make.left.right.equalTo(view)
            make.size.equalTo(CGSize.init(width: SCREENW, height: 45))
        }
        
        
        let request = URLRequest.init(url: URL.init(string: newsTopic!.url!)!)
        webView.loadRequest(request)
        bottomView.commentCount = newsTopic?.comment_count
        
    }

    
    
    
    
    fileprivate lazy var webView : UIWebView = {
       let webView = UIWebView.init()
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        return webView
    }()
    
    
    
    fileprivate lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar.init()
        searchBar.height = 30
        searchBar.width = SCREENW - 60
        return searchBar
    }()
    
    fileprivate lazy var bottomView : YTHomeDetailBottomView = {
       let bottomView = Bundle.main.loadNibNamed("YTHomeDetailBottomView", owner: nil, options: nil)?.last as! YTHomeDetailBottomView
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    
    //MARK:-------- 按钮点击
    @objc fileprivate func more() {
        
    }
    
    
    


}
