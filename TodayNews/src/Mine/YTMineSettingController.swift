//
//  YTMineSettingController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/8.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

let settingTypeOneCell = "YTSettingTypeOneCell"
let settingTypeTwoCell = "YTSettingTypeTwoCell"
let settingTypeThreeCell = "YTSettingTypeThreeCell"


import UIKit

class YTMineSettingController: YTBaseController {

    //数据集合
    var cellSettingsData = [AnyObject]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "leftbackicon_sdk_login_16x16_"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        
        loadData()
        setupUI()
        
    }


    fileprivate func loadData() {
        let path = Bundle.main.path(forResource: "YMSettingPlist.plist", ofType: nil)
        let dataArr = NSArray.init(contentsOfFile: path!)
        for items in dataArr! {
            var itemArr = [YTMineSettingModel]()
            for item in items as! [Dictionary<String,Any>] {
                let model = YTMineSettingModel.init(dic: item)
                itemArr.append(model)
            }
            cellSettingsData.append(itemArr as AnyObject)
        }
    }
    
    fileprivate func setupUI() {
        let tableView = UITableView.init(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let cellOneType = UINib.init(nibName: settingTypeOneCell, bundle: nil)
        let cellTwoType = UINib.init(nibName: settingTypeTwoCell, bundle: nil)
        let cellThreeType = UINib.init(nibName: settingTypeThreeCell, bundle: nil)
        tableView.register(cellOneType, forCellReuseIdentifier: settingTypeOneCell)
        tableView.register(cellTwoType, forCellReuseIdentifier: settingTypeTwoCell)
        tableView.register(cellThreeType, forCellReuseIdentifier: settingTypeThreeCell)
        
        
    }
    
    
    @objc fileprivate func back() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
}



extension YTMineSettingController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellSettingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = cellSettingsData[section] as? NSArray
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView.init()
        sectionHeader.backgroundColor = YMColor(243.0, g: 246.0, b: 246.0, a: 1.0)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 8
        } else {
            return 16
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = (cellSettingsData[indexPath.section] as! NSArray)[indexPath.row] as! YTMineSettingModel
        if model.isHiddenArraw == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingTypeOneCell) as! YTSettingTypeOneCell
            cell.model = model
            return cell
        } else if model.isHiddenSwitch == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingTypeTwoCell) as! YTSettingTypeTwoCell
            cell.model = model
            return cell
        } else if model.isHiddenRightTitle == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: settingTypeThreeCell) as! YTSettingTypeThreeCell
            cell.model = model
            return cell
        }
        return UITableViewCell()
    }
    
    
}



