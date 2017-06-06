//
//  YTFollowController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//



let newCareNoLoginCellID = "YMNewCareNoLoginCell"
let newCareTopCellID = "YMNewCareTopCell"
let newCareBottomCellID = "YMNewCareBottomCell"


import UIKit




class YTFollowController: YTBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }


    
    
    fileprivate func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "search_topic_24x24_"), style: .plain, target: self, action: #selector(search))
        
        let tableView : UITableView = UITableView.init(frame: view.bounds, style: .grouped)
        //注册cell
        let nologinCell = UINib.init(nibName: "YTCareNoLoginCell", bundle: nil)
        tableView.register(nologinCell, forCellReuseIdentifier: newCareNoLoginCellID)

        let topCell = UINib.init(nibName: "YTCareTopCell", bundle: nil)
        tableView.register(topCell, forCellReuseIdentifier: newCareTopCellID)
        
        let bottomCell = UINib.init(nibName: "YTCareBottomCell", bundle: nil)
        tableView.register(bottomCell, forCellReuseIdentifier: newCareBottomCellID)
        
        
    }
    
    
    
    
    //MAEK: --导航点击 搜索
    @objc fileprivate func search() {
        
    }
    
    
    
}
