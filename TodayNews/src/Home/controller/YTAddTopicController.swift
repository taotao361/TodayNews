//
//  YTAddTopicController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/27.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTAddTopicController: YTBaseController {

    //我的
    var myTopics = [YTHomeCategoryTitles]()
    //推荐
    var recommentTopics = [YTHomeCategoryTitles]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        YTNetworkService.shareNetService.loadRecommendChannels { [weak self] (categorys) in
            self?.recommentTopics = categorys
            print(self?.recommentTopics ?? "no have")
        }
        
    }


    
    fileprivate func  setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "add_channels_close_20x20_"), style: .plain, target: self, action: #selector(click))
    }


    @objc fileprivate func click() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    

}
