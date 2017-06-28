//
//  YTVideoTopTitleModel.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/28.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTVideoTopTitleModel: NSObject {
    
    var category : String?
    var name : String?
    var icon_url : String?
    var web_url : String?
    var flags : Int?
    var tip_new : Int?
    var type : Int?
    
    init(dic : [String : AnyObject]) {
        super.init()
        category = dic["category"] as? String
        name = dic["name"] as? String
        icon_url = dic["icon_url"] as? String
        web_url = dic["web_url"] as? String
        flags = dic["flags"] as? Int
        tip_new = dic["tip_new"] as? Int
        type = dic["type"] as? Int
    }
    
    
}









