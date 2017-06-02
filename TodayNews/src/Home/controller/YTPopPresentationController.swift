//
//  YTPopPresentationController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/2.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

//负责转场动画的控制器
class YTPopPresentationController: UIPresentationController {

    var presentFrame = CGRect.zero
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    
    //即将布局专场子视图时调用
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //containerView 容器视图
        // presentedView 被展示的视图
        
        containerView?.insertSubview(coverView, at: 0)
        presentedView?.frame = presentFrame
        
    }
    
    
    fileprivate lazy var coverView : UIView = {
       let vv = UIView.init()
        vv.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        vv.frame = UIScreen.main.bounds
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissCoverView))
        vv.addGestureRecognizer(tap)
        return vv
    }()
    
    
    
    @objc fileprivate func dismissCoverView() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
