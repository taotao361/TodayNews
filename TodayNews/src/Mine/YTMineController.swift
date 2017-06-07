//
//  YTMineController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

let mineCell = "YTMineCell"

class YTMineController: YTBaseController {

    var cellItems = [AnyObject]()
    
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
        //
        let islogin = false
        let headerView = YTMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: islogin ? 261 : 248))
        headerView.isLogin = islogin
        tableView.tableHeaderView = headerView
        
        let mineNibCell = UINib.init(nibName: "YTMineCell", bundle: nil)
        tableView.register(mineNibCell, forCellReuseIdentifier: mineCell)
        
    }


    fileprivate func loadData() {
        let path = Bundle.main.path(forResource: "YMMineCellPlist.plsit", ofType: nil)
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
    
    
    
    
    
    
}


extension YTMineController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemArr = cellItems[section] as? NSArray
        return itemArr!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init()
        header.backgroundColor = UIColor.gray
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelArr = cellItems[indexPath.section]
        let model = modelArr[indexPath.row] as! YTMineModel
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCell) as! YTMineCell
        cell.mineModel = model
        return cell
    }
    
    
}




