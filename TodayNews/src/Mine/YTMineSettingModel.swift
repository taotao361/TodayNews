//
//  YTMineSettingModel.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/8.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTMineSettingModel: NSObject {

    var title : String?
    var subtitle : String?
    var rightTitle : String?
    var isHiddenSubtitle : Bool?
    var isHiddenSwitch : Bool?
    var isHiddenArraw : Bool?
    var isHiddenRightTitle : Bool?
    init(dic : [String : Any]) {
        title = dic["title"] as? String
        subtitle = dic["subtitle"] as? String
        rightTitle = dic["rightTitle"] as? String
        isHiddenSubtitle = dic["isHiddenSubtitle"] as? Bool
        isHiddenSwitch = dic["isHiddenSwitch"] as? Bool
        isHiddenArraw = dic["isHiddenArraw"] as? Bool
        isHiddenRightTitle = dic["isHiddenRightTitle"] as? Bool
    }
    
    
}
