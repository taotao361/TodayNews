//
//  YTNetworkService.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import MJRefresh


class YTNetworkService: NSObject {

    //单例
    static let shareNetService = YTNetworkService()
    
    //获取首页不同分类的新闻内容 函数类型的参数，在函数内部不能有标签参数               逃逸
    func loadHomeCatagoryNews(catagory : String,tableView : UITableView, finish : @escaping (_ nowTime : TimeInterval,_ newsTopics : [YTNewsTopic]) -> Void) {
        let url = BASE_URL + "api/news/feed/v39/?"
        let paras = ["device_id":device_id,"catagory":catagory,"iid":IID]
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock : {
            let nowTime = Date.init().timeIntervalSince1970
            Alamofire.request(url, method: .get, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                tableView.mj_header.endRefreshing()
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                
                if let value = response.result.value {
                    let json = JSON.init(value)//转换字典
                    let jsonDatas = json["data"].array //数据数组
                    print("================  \(jsonDatas)")
                    var newsList = [YTNewsTopic].init()
                    for data in jsonDatas! {
                        let content = data["content"].stringValue
                        let contentData : Data = content.data(using: String.Encoding.utf8)!
                        
                        do {
                            let dic = try JSONSerialization.jsonObject(with: contentData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic = YTNewsTopic.init(dict: dic as! [String:AnyObject])
                            newsList.append(topic)
                        } catch  {
                            SVProgressHUD.showError(withStatus: "获取数据失败")
                        }
                    }
                    finish(nowTime,newsList)
                }
                
            })
        })
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
    }
    
    
    //获取首页顶部 标题内容集合
    func loadHomeTitleList(finish : @escaping (_ topTitles : [YTHomeCategoryTitles])-> Void) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let paras : [String : Any] = ["device_id":device_id,"iid":IID,"aid":13]
        Alamofire.request(url, method: HTTPMethod.get, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            
            if let value = response.result.value {
                let jsonData = JSON.init(value)
                print(jsonData)
                let dicData = jsonData["data"].dictionary
                if let arrDatas = dicData?["data"]?.arrayObject {
                    var titlesData = [YTHomeCategoryTitles].init()
                    for item in arrDatas {
                        let titleItem = YTHomeCategoryTitles.init(dic: (item as! [String : AnyObject]))
                        titlesData.append(titleItem)
                    }
                    finish(titlesData)
                }
            }
        }
    }
    
    
    ///新文章数量
    func loadTopicRefreshTip(_ closure : @escaping (_ count : Int) -> Void) {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            if let value = response.result.value {
                let jsonData = JSON.init(value)
                let data = jsonData["data"].dictionary
                let c = data!["count"]!.int //类型转换
                closure(c!)
            }
        }
    }
    
    
    //MARK:-----推荐频道
    func loadRecommendChannels(_ finish : @escaping (_ recommendChannels : [YTHomeCategoryTitles])->Void) {
        let url = BASE_URL + "/article/category/get_extra/v1/?"
        let paras : [String:Any] = ["device_id":device_id,"iid":IID,"aid":13]
        Alamofire.request(url, method: .get, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            if let value = response.result.value {
                let json = JSON.init(value)
                let dataDic = json["data"].dictionary
                if let dataArray =  dataDic?["data"]?.arrayObject {
                    var categorys = [YTHomeCategoryTitles]()
                    for cate in dataArray {
                        let c = YTHomeCategoryTitles.init(dic: (cate as! [String:AnyObject]))
                        categorys.append(c)
                    }
                    finish(categorys)
                }
            }
        }
    }
    
    
    
    //关心数据列表
    func loadConcernDatas(_ finish : @escaping (_ topConcern : [YTConcernModel],_ bottomConcern : [YTConcernModel]) -> Void) {
        let url = BASE_URL + "concern/v1/concern/list/"
        let paras = ["iid":IID,"count" : 20,"offset":0,"type":"manage"] as [String : Any]
        Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            if let value = response.result.value {
                let json = JSON.init(value)
                if let concern_list = json["concern_list"].arrayObject {
                    var top = [YTConcernModel]()
                    var bottom = [YTConcernModel]()
                    for dic in concern_list {
                        let concern = YTConcernModel.init(dic: dic as! [String : AnyObject])
                        concern.concern_time != 0 ? top.append(concern) : bottom.append(concern)
                    }
                    finish(top,bottom)
                }
            }
        }
    }
    
    
    //获取更多 关心数据
    func laodMoreConcernDatas(_ tableView : UITableView,outOffset : Int,_ finish : @escaping (_ inOffset : Int,_ top : [YTConcernModel],_ bottom : [YTConcernModel]) -> Void) {
        let url = BASE_URL + "concern/v1/concern/list/"
        let paras = ["iid" : IID,"count":20,"offset":outOffset,"type":"manage"] as [String:Any]
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            Alamofire.request(url, method: .post, parameters: paras, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                if let value = response.result.value {
                    let json = JSON.init(value)
                    let inOffset = json["offset"].int!
                    if let concern_list = json["concern_list"].arrayObject {
                        var top = [YTConcernModel]()
                        var bottom = [YTConcernModel].init()
                        for dic in concern_list {
                            let concern = YTConcernModel.init(dic: dic as! [String : AnyObject])
                            (concern.concern_time != 0) ? top.append(concern) : bottom.append(concern)
                        }
                        finish(inOffset,top,bottom)
                    }
                }
            })
        })
    }
    
    
    
    
    
    
}
