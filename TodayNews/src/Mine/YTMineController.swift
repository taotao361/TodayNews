//
//  YTMineController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

let mineCell = "YTMineCell"
let headerViewIdentifier = "headerViewIdentifier"

class YTMineController: YTBaseController {

    var cellItems = [AnyObject]()
    
//    var aa = [Op]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        view.addSubview(tableView)
        //
        let islogin = true
        let headerView = YTMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: islogin ? 278 : 248))
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        headerView.isLogin = islogin
        tableView.tableHeaderView = headerView
        let mineNibCell = UINib.init(nibName: "YTMineCell", bundle: nil)
        tableView.register(mineNibCell, forCellReuseIdentifier: mineCell)
        
        //点击事件
        headerView.bottomItemDidClick = { [weak self] (item) in
            if item.titleLabel?.text == "设置" {
                let settingVC = YTMineSettingController()
//                settingVC.tabBarItem.title = "setting"
//                settingVC.tabBarItem.image = UIImage.init(named: "newcare_tabbar_22x22_")
                settingVC.title = "设置"
                self?.navigationController?.pushViewController(settingVC, animated: true)
            }
        }
        
    }


    fileprivate func loadData() {
        let path = Bundle.main.path(forResource: "YMMineCellPlist.plist", ofType: nil)
        let itemsArr = NSArray.init(contentsOf: URL.init(fileURLWithPath: path!))
        for arr in itemsArr! {
            var sections = [AnyObject]()
            for item in arr as! [Dictionary<String, Any>] {
                let model = YTMineModel.init(dic: item)
                sections.append(model)
            }
            cellItems.append(sections as AnyObject)
        }
    }
    
    
    fileprivate lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    
    
    //MARK:---旋转
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    
    
}


extension YTMineController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemArr = cellItems[section] as? NSArray
//        print("================\(itemArr!.count)")
        return itemArr!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //header 复用
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier)
//        if header != nil {
//            return header
//        } else {
            let header = UIView.init()
            header.backgroundColor = YMColor(243.0, g: 246.0, b: 246.0, a: 1.0)
            return header
//        }
    }
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView.init()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelArr = cellItems[indexPath.section] as? [AnyObject]
        let model = modelArr?[indexPath.row] as! YTMineModel
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCell) as! YTMineCell
        cell.mineModel = model
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}




