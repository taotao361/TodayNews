//
//  YTMineModel.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/7.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTMineModel: NSObject {
    var title : String?
    var subtitle : String?
    var isHiddenLine : Bool?
    var isHiddenSubtitle : Bool?
    init(dic : [String : Any]) {
        super.init()
        title = dic["title"] as? String
        subtitle = dic["subtitle"] as? String
        isHiddenLine = dic["isHiddenLine"] as? Bool
        isHiddenSubtitle = dic["isHiddenSubtitle"] as? Bool
    }
    
}
