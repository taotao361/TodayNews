//
//  YTConcernModel.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/6.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTConcernModel: NSObject {

    var concern_time : Int = 0
    var concern_count : Int = 0
    var open_url : String = ""
    var name : String = ""
    var managing : Int = 0
    var concern_id : String = ""
    var sub_title : String = ""
    var new_thread_count : Int = 0
    var avatar_url : String = ""
    var newly : Int = 0
    var discuss_count : Int = 0
    
    init(dic : [String : AnyObject]) {
        super.init()
        concern_id = dic["concern_id"] as! String
        concern_time = dic["concern_time"] as! Int
        open_url = dic["open_url"] as! String
        name = dic["name"] as! String
        managing = dic["managing"] as! Int
        sub_title = dic["sub_title"] as! String
        newly = dic["newly"] as! Int
        new_thread_count = dic["new_thread_count"] as! Int
        discuss_count = dic["discuss_count"] as! Int
        avatar_url = dic["avatar_url"] as! String
    }
    
}

/*
"concern_time": 1495603420,
"concern_count": 287316,
"open_url": "sslocal://concern?enter_from=click_concerned&gd_ext_json=%7B%22concern_id%22%3A+%226213179255841360386%22%2C+%22enter_from%22%3A+%22click_concerned%22%7D&cid=6213179255841360386",
"name": "赵本山",
"managing": 0,
"concern_id": "6213179255841360386",
"sub_title": "",
"new_thread_count": 2004,
"avatar_url": "http://p3.pstatp.com/thumb/1263000790497aead2cc",
"newly": 1,
"discuss_count": 10586
*/
