//
//  YTHomeTopicController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/27.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

let topicSmallCellID = "topicSmallCellID"
let topicLargeCellID = "topicLargeCellID"
let topicNoImageCellID = "topicNoImageCellID"
let topicMiddleCellID = "topicMiddleCellID"

class YTHomeTopicController: UITableViewController {
    
    //上一次选中的tabBar index
    var lastSelectedIndex = 0
    // 记录点击的顶部标题
    var topTitle: YTHomeCategoryTitles?
    
    //下拉刷新的时间
    fileprivate var pullRefreshTime : TimeInterval?
    //存放新闻主题的数组
    fileprivate var newsTopics = [YTNewsTopic]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupRefresh()

    }

    fileprivate func setupUI() {
        self.definesPresentationContext = true
        tableView.contentInset = UIEdgeInsetsMake(54, 0, 0, 0)
        //注册cell
        tableView.register(YTHomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
        tableView.register(YTHomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        tableView.register(YTHomeMiddleCell.self, forCellReuseIdentifier: topicMiddleCellID)
        tableView.register(YTHomeNoImageCell.self, forCellReuseIdentifier: topicNoImageCellID)
        
        //预设cell高度为 100
        tableView.estimatedRowHeight = 150
        
        //头部
        
        //监听 tabbar 点击
        NotificationCenter.default.addObserver(self, selector: #selector(tabBarSelected), name: NSNotification.Name(rawValue: YMTabBarDidSelectedNotification), object: nil)
        
        
    }
    
    func tabBarSelected() {
        //如果是连点 2 次，并且 如果选中的是当前导航控制器，刷新
        if lastSelectedIndex == tabBarController?.selectedIndex {
            tableView.mj_header.beginRefreshing()
        }
        lastSelectedIndex = self.tabBarController!.selectedIndex
    }
    
    //添加上拉 下拉刷新
    fileprivate func setupRefresh() {
        pullRefreshTime = Date.init().timeIntervalSince1970
        
        //获取首页不同分类的新闻内容
        YTNetworkService.shareNetService.loadHomeCatagoryNews(catagory: topTitle!.category!, tableView: tableView) { [weak self] (nowTime, topics) in
            self?.pullRefreshTime = nowTime
            self?.newsTopics = topics
            self?.tableView.reloadData()
        }
    }
    
    
    
    /// 点击✘弹出view
    /// - Parameters:
    ///   - filterWords: filter数组
    ///   - point: 相对坐标
    fileprivate func showPopView(_ filterWords : [YTFilterWords],point : CGPoint) {
        let popVC = YTPopController()
        popVC.filterWords = filterWords
        //设置专场动画的代理
        //默认情况下，model视图控制器 会移除上一个 控制器的view，替换为当前弹出的控制器
        //如果自定义转场动画，就不会移除上一个控制器的view
        popVC.transitioningDelegate = popAnimator
        switch filterWords.count {
        case 0:
            popAnimator.presentViewFrame = CGRect.zero
        case 1, 2:
            popAnimator.presentViewFrame = CGRect(x: kHomeMargin, y: point.y, width: SCREENW - 2 * kHomeMargin, height: 104)
        case 3, 4:
            popAnimator.presentViewFrame = CGRect(x: kHomeMargin, y: point.y, width: SCREENW - 2 * kHomeMargin, height: 141)
        case 5, 6:
            popAnimator.presentViewFrame = CGRect(x: kHomeMargin, y: point.y, width: SCREENW - 2 * kHomeMargin, height: 190)
        default:
            popAnimator.presentViewFrame = CGRect.zero
        }
        
        //设置专场样式
        popVC.modalPresentationStyle = .custom
        present(popVC, animated: true, completion: nil)
        
    }
    
    
    fileprivate lazy var popAnimator : YTPopViewAnimator =  YTPopViewAnimator.init()
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsTopics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topic = newsTopics[indexPath.row]
        if topic.image_list.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: topicSmallCellID) as! YTHomeSmallCell
            cell.newsTopic = topic
            cell.closeBtnDidClick({ [weak self] (filters) in
                //某行的cell所对应的在tableView上的位置
                let cellRectInTableView = tableView.rectForRow(at: indexPath)
                //
                let point = tableView.convert(cellRectInTableView, to: tableView.superview).origin
                let convertPoint = CGPoint.init(x: point.x, y: point.y+cell.closeBtn.y)
                self?.showPopView(filters!, point: convertPoint)
            })
            return cell
        } else {
            if topic.middle_image != nil {
                if topic.video_detail_info?.video_id != nil || topic.large_image_list?.count != 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicLargeCellID) as! YTHomeLargeCell
                    cell.newTopic = topic
                    cell.closeBtnDidClick({ (filters) in
                        //某行的cell所对应的在tableView上的位置
                        let cellRectInTableView = tableView.rectForRow(at: indexPath)
                        //
                        let point = tableView.convert(cellRectInTableView, to: tableView.superview).origin
                        let convertPoint = CGPoint.init(x: point.x, y: point.y+cell.closeBtn.y)
                        self.showPopView(filters!, point: convertPoint)
                    })
                    return cell
                } else {
                    let cell  = tableView.dequeueReusableCell(withIdentifier: topicMiddleCellID) as! YTHomeMiddleCell
                    cell.newTopic = topic
                    cell.closeBtnDidClick({ (filters) in
                        //某行的cell所对应的在tableView上的位置
                        let cellRectInTableView = tableView.rectForRow(at: indexPath)
                        //
                        let point = tableView.convert(cellRectInTableView, to: tableView.superview).origin
                        let convertPoint = CGPoint.init(x: point.x, y: point.y+cell.closeBtn.y)
                        self.showPopView(filters!, point: convertPoint)
                    })
                    return cell
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: topicNoImageCellID) as! YTHomeNoImageCell
                cell.newsTopic = topic
                cell.closeBtnDidClick({ (filters) in
                    //某行的cell所对应的在tableView上的位置
                    let cellRectInTableView = tableView.rectForRow(at: indexPath)
                    //
                    let point = tableView.convert(cellRectInTableView, to: tableView.superview).origin
                    let convertPoint = CGPoint.init(x: point.x, y: point.y+cell.closeBtn.y)
                    self.showPopView(filters!, point: convertPoint)
                })
                return cell
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let topic = newsTopics[indexPath.row]
        return topic.cellHeight
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    

}
