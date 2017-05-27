//
//  YTHomeController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTHomeController: YTBaseController {

    //当前选中的titleLabel的上一个
    var oldIndex : Int = 0
    //首页顶部标题数组
    var homeTitles = [YTHomeCategoryTitles]()
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI
        setupUI()
        //处理顶部导航标题view的回调
        homeTitleViewCallback()
        //显示有多少条新文章
        showRefreshTipView()
        
    }


    fileprivate func  setupUI () {
        view.backgroundColor = YMGlobalColor()
        //不自动调整 inset
        self.automaticallyAdjustsScrollViewInsets = false
        //设置导航栏属性
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = YMColor(210, g: 63, b: 66, a: 1.0)
        //设置titleView
        self.navigationItem.titleView = titleView
        //添加滚动视图
        self.view.addSubview(scrollView)
    }
    
    
    
    //顶部导航自定义view
    fileprivate lazy var titleView : YTScrollTitleView = YTScrollTitleView()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.frame = UIScreen.main.bounds
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    //文章更新提示view
    fileprivate lazy var tipView : YTTipView = {
        let tip = YTTipView()
        tip.frame = CGRect.init(x: 0, y: 44, width: SCREENW, height: 35)
        return tip
    }()
    
    
    
    //处理导航标题title 的回调
    fileprivate func homeTitleViewCallback() {
        //返回标题的数量
        titleView.titleArrayClosure { [weak self] (models) in
            self?.homeTitles = models
            //归档标题数据
            self?.archiveTitles(models)
            for topTitle in models {
                let VC = YTHomeTopicController()
                VC.topTitle = topTitle
                self?.addChildViewController(VC) //添加VC
            }
            self?.scrollViewDidEndScrollingAnimation(self!.scrollView)
            self?.scrollView.contentSize = CGSize.init(width: SCREENW*CGFloat(models.count), height: SCREENH)
        }
        
        //添加按钮点击
        titleView.addButtonClickClosure { [weak self] in
            let addVC = YTAddTopicController()
            addVC.myTopics = self!.homeTitles
            let nav = YTBaseNavController.init(rootViewController: addVC)
            self?.present(nav, animated: true, completion: nil)
        }
        
        //点击了哪个titleLabel
        titleView.didSelectTitleLabelClosure { [weak self] (titleLabel) in
            var offset = self!.scrollView.contentOffset
            offset.x = CGFloat.init(titleLabel.tag) * self!.scrollView.width
            self!.scrollView.contentOffset = offset
        }
    }

    //归档标题数组
    fileprivate func archiveTitles(_ titles : [YTHomeCategoryTitles]) {
        let path : NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        let filePath = path.appendingPathComponent("top_titles_archive")
        //归档
        NSKeyedArchiver.archiveRootObject(titles, toFile: filePath)
    }

    ///显示有多少条新文章
    fileprivate func showRefreshTipView() {
        YTNetworkService.shareNetService.loadTopicRefreshTip { [weak self] (count) in
            if !(self!.navigationController?.navigationBar.subviews.contains(self!.tipView))! {
                self!.navigationController?.navigationBar.insertSubview(self!.tipView, at: 0)//加到navigationBar上
            }
            self!.tipView.tipLabel.text = count == 0 ? "暂无更新，请休息一会儿" : "今日头条推荐引擎有\(count)条刷新"
            UIView.animate(withDuration: kAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: { 
                        self?.tipView.tipLabel.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            }, completion: { (_) in
                self?.tipView.tipLabel.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                let delayTime = DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime, execute: { 
                    self!.tipView.isHidden = true
                })
            })
        }
    }
    
    
}


extension YTHomeController : UIScrollViewDelegate {
    
    //当动画结束时调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //取出子控制器
        let vc = self.childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    //scrollView 刚开始 滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //当前索引
        let index = Int(scrollView.contentOffset.x/scrollView.width)
        //记录刚开始拖拽的 index
        self.oldIndex = index
    }
    
    //scrollView 停止加速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //当期那索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //跟刚开始拖拽时的 index 比较，是否需要改变 label 的位置
        titleView.adjustTitleOffsetToCurrentIndex(index, oldIndex: self.oldIndex)
        
        //取出子控制器
        let vc = self.childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}









