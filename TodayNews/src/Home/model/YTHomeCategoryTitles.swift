//
//  YTHomeCatagoryTitles.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/27.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import Foundation

/// 首页显示的 标题分类数据
class YTHomeCategoryTitles: NSObject,NSCoding {

    var category : String?
    var web_url : String?
    var flags : Int?
    var name : String?
    var tip_new : Int?
    var default_add : Int?
    var concern_id : String?
    var type : Int?
    var icon_url : String?
    init(dic : [String : AnyObject]) {
        super.init()
        category = dic["category"] as? String
        web_url = dic["web_url"] as? String
        flags = dic["flags"] as? Int
        name = dic["name"] as? String
        tip_new = dic["tip_new"] as? Int
        default_add = dic["default_add"] as? Int
        concern_id = dic["concern_id"] as? String
        type = dic["type"] as? Int
        icon_url = dic["icon_url"] as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(flags, forKey: "flags")
        coder.encode(type, forKey: "type")
        coder.encode(tip_new, forKey: "tip_new")
        coder.encode(default_add, forKey: "default_add")
        coder.encode(icon_url, forKey: "icon_url")
        coder.encode(concern_id, forKey: "concern_id")
        coder.encode(name, forKey: "name")
        coder.encode(category, forKey: "category")
        coder.encode(web_url, forKey: "web_url")
    }
    
    required init?(coder decoder: NSCoder) {
        super.init()
        category = decoder.decodeObject(forKey: "category") as? String
        web_url = decoder.decodeObject(forKey: "web_url'") as? String
        flags = decoder.decodeInteger(forKey: "flags")
        name = decoder.decodeObject(forKey: "name") as? String
        tip_new = decoder.decodeInteger(forKey: "tip_new")
        default_add = decoder.decodeInteger(forKey: "default_add")
        concern_id = decoder.decodeObject(forKey: "concern_id") as? String
        type = decoder.decodeInteger(forKey: "type")
        icon_url = decoder.decodeObject(forKey: "icon_url") as? String
    }
    
    
    
    
}



