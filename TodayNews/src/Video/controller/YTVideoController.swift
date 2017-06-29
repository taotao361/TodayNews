//
//  YTVideoController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTVideoController: YTBaseController {

    //前一个控制器view的位置
    var oldIndex : Int = 0
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.titleView = titleView
        setupUI()
        
    }


    fileprivate func setupUI() {
        view.addSubview(scrollView)
        titleView.allTitleModels =  { (models) in
            for titleModel in models {
                let listVC = YTVideoListController()
                listVC.titleModel = titleModel
                self.addChildViewController(listVC)
            }
            //添加view
            self.scrollViewDidEndScrollingAnimation(self.scrollView)
            self.scrollView.contentSize = CGSize.init(width: SCREENW*CGFloat(models.count), height: SCREENH-64)
        }
    }
    

    
    
    
    
    //MARK:----------lazy
    fileprivate lazy var titleView : YTVideoTitleView = {
       let titleView = YTVideoTitleView()
        titleView.frame = CGRect.init(x: 0, y: 0, width: SCREENW, height: 44)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
       let scroll = UIScrollView()
        scroll.frame = CGRect.init(x: 0, y: 64, width: SCREENW, height: SCREENH-64)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.delegate = self
        scroll.isPagingEnabled = true
        return scroll
    }()

    
    
    
    
    
}


extension YTVideoController : UIScrollViewDelegate,YTVideoTitleViewDelegate {
    
    //MARK:------ scrollview delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        oldIndex = index
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        titleView.adjustTitleLabel(oldIndex: oldIndex, currentIndex: index)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
        titleView.adjustTitleLabel(oldIndex: oldIndex, currentIndex: index)
    }
    
    //MAARK:-------- YTVideoTitleViewDelegate
    func videoTitle(videoTitleView: YTVideoTitleView, didSelectedVideoTitle videoTitle: YTVideoTopTitleModel, index: Int) {
        let vc = childViewControllers[index]
        vc.view.x = CGFloat(index)*SCREENW
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
        scrollView.setContentOffset(CGPoint.init(x: vc.view.x, y: 0), animated: true)
        
    }
    
    func videoTitle(videoTitleView: YTVideoTitleView, didSelectedVideoSearchBtn btn: UIButton) {
        
    }
    
}


































