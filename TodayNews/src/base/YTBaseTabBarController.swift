//
//  YTBaseTabBarController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加子控制器
        addChildControllers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func addChildControllers() {
        addChild(YTHomeController(), title: "首页", imageName: "home_tabbar_22x22_", selectedName: "home_tabbar_press_22x22_")
        addChild(YTVideoController(), title: "视频", imageName: "video_tabbar_22x22_", selectedName: "video_tabbar_press_22x22_")
        addChild(YTFollowController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedName: "newcare_tabbar_press_22x22_")
        addChild(YTMineController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedName: "mine_tabbar_press_22x22_")
    }
    
    fileprivate func addChild(_ viewController : UIViewController,title : String,imageName : String,selectedName : String) {
        viewController.tabBarItem.image = UIImage.init(named: imageName)
        viewController.tabBarItem.selectedImage = UIImage.init(named: selectedName)
        viewController.title = title
        let nav = YTBaseNavController.init(rootViewController: viewController)
        self.addChildViewController(nav)
    }
    
    
    
}
