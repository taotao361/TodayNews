//
//  YTFollowController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//



let newCareNoLoginCellID = "YTCareNoLoginCell"
let newCareTopCellID = "YTCareTopCell"
let newCareBottomCellID = "YTCareBottomCell"


import UIKit
import MJRefresh



class YTFollowController: YTBaseController {

    var topConcernModels = [YTConcernModel]()
    var bottomConcernModels = [YTConcernModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        refresh()
        loadMore()
    }


    
    
    fileprivate func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "search_topic_24x24_"), style: .plain, target: self, action: #selector(search))
        
        view.addSubview(tableView)
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH)
        
        let refreshHeader = MJRefreshStateHeader.init()
        refreshHeader.beginRefreshing {
            self.refresh()
        }
        refreshHeader.setTitle("下拉刷新数据", for: MJRefreshState.idle)
        refreshHeader.setTitle("松手即可刷新", for: MJRefreshState.pulling)
        refreshHeader.setTitle("正在刷新数据中。。。", for: MJRefreshState.refreshing)
        tableView.mj_header = refreshHeader
        tableView.mj_header.beginRefreshing()
        
        
        //注册cell
        let nologinCell = UINib.init(nibName: "YTCareNoLoginCell", bundle: nil)
        tableView.register(nologinCell, forCellReuseIdentifier: newCareNoLoginCellID)

        let topCell = UINib.init(nibName: "YTCareTopCell", bundle: nil)
        tableView.register(topCell, forCellReuseIdentifier: newCareTopCellID)
        
        let bottomCell = UINib.init(nibName: "YTCareBottomCell", bundle: nil)
        tableView.register(bottomCell, forCellReuseIdentifier: newCareBottomCellID)
        
        
    }
    
    fileprivate func refresh() {
        YTNetworkService.shareNetService.loadConcernDatas { [weak self] (tops, bottoms) in
            self!.tableView.mj_header.endRefreshing()
            self!.topConcernModels.removeAll()
            self!.bottomConcernModels.removeAll()
//            self!.topConcernModels = tops
            self!.bottomConcernModels = tops
            self!.tableView .reloadData()
        }
    }
    
    fileprivate func loadMore() {
        YTNetworkService.shareNetService.loadMoreConcernDatas(tableView, outOffset: 5) { [weak self] (inOffset, tops, bottoms) in
            self!.tableView.mj_footer.endRefreshing()
            self!.topConcernModels += tops
            self!.bottomConcernModels += bottoms
            self!.tableView.reloadData()
        }
    }
    
    
    fileprivate lazy var tableView : UITableView = {
       let tableView : UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        return tableView
    }()
    
    
    
    
    
    
    //MAEK: --导航点击 搜索
    @objc fileprivate func search() {
        print("search")
    }
    
    
    
}



extension YTFollowController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if topConcernModels.count == 0 { return 1 }
            return topConcernModels.count
        } else { return bottomConcernModels.count }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if topConcernModels.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: newCareNoLoginCellID) as! YTCareNoLoginCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: newCareTopCellID) as! YTCareTopCell
                cell.concern = topConcernModels[indexPath.row]
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: newCareBottomCellID) as! YTCareBottomCell
            cell.concern = bottomConcernModels[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = YTSectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 30))
        section == 0 ? (headerView.titleLabel.text = "正在关心") : (headerView.titleLabel.text = "可能关心")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(#function)
    }
    
    
}



class YTSectionView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(titleLabel)
        addSubview(redView)
        
        redView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(20)
            make.size.equalTo(CGSize.init(width: 4, height: 10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(redView.snp.top)
            make.left.equalTo(redView.snp.right).offset(5)
            make.size.equalTo(CGSize.init(width: 100, height: 10))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel : UILabel = {
       let label = UILabel.init()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    fileprivate lazy var redView : UIImageView = {
       let redView = UIImageView.init()
        redView.backgroundColor = UIColor.red
        return redView
    }()
    
}










