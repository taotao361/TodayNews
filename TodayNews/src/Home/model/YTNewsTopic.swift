//
//  YTNewsTopic.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  每条新闻的内容

import UIKit

class YTNewsTopic: NSObject {

//    // 文字的高度
//    var titleH: CGFloat = 0
//    var titleW: CGFloat = 0
//    var imageW: CGFloat = 0
//    var imageH: CGFloat = 0
//    var cellHeight: CGFloat = 0
    
    var abstract: String?
    
    var keywords: String?
    
    var title: String?
    ///置顶 热 视频等
    var label: String?
    
    var article_alt_url: String?
    var article_url: String?
    var display_url: String?
    var share_url: String?
    var url: String?
    
    var item_id: Int?
    
    var tag_id: Int?
    var tag: String?
    
    var read_count: Int?
    var comment_count: Int?
    var repin_count: Int?
    var digg_count: Int?
    
    var publish_time: Int?
    
    var source: String?
    var source_avatar: String?
    
    var group_id: Int?
    var gallary_image_count: Int?
    
    var has_image: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var has_video: Bool?
    
    var video_detail_info: YTVideoDetailInfo?
    
    var video_style: Int?
    var video_duration: Int?
    var video_id: Int?

    //点击item 叉号 弹出的内容
    var filter_words : [YTFilterWords]?
    
    var image_list = [YTImageList]()
    var middle_image: YTMiddleImageList?
    var large_image_list : [YTLargeImageList]?
    
    var behot_time: Int?
    
    var cell_flag: Int?
    var bury_count: Int?
    
    var article_type: Int?
    
    var cursor: Int?
    
    var media_info: YTMediaInfo?
    init(dict : [String : AnyObject]) {
        super.init()
        cursor = dict["cursor"] as? Int
        
        title = dict["title"] as? String
        
        article_type = dict["article_type"] as? Int
        
        url = dict["url"] as? String
        article_url = dict["article_url"] as? String
        article_alt_url = dict["article_alt_url"] as? String
        
        bury_count = dict["bury_count"] as? Int
        cell_flag = dict["cell_flag"] as? Int
        behot_time = dict["behot_time"] as? Int
        
        has_video = dict["has_video"] as? Bool
        has_mp4_video = dict["has_mp4_video"] as? Bool
        has_m3u8_video = dict["has_m3u8_video"] as? Bool
        has_image = dict["has_image"] as? Bool
        
        video_duration = dict["video_duration"] as? Int
        video_id = dict["video_id"] as? Int
        video_style = dict["video_style"] as? Int
        
        group_id = dict["group_id"] as? Int
        
        tag = dict["tag"] as? String
        tag_id = dict["tag_id"] as? Int
        item_id = dict["item_id"] as? Int
        
        read_count = dict["read_count"] as? Int
        comment_count = dict["comment_count"] as? Int
        repin_count = dict["repin_count"] as? Int
        digg_count = dict["digg_count"] as? Int
        
        publish_time = dict["publish_time"] as? Int
        
        keywords = dict["keywords"] as? String
        abstract = dict["abstract"] as? String
        
        source = dict["source"] as? String
        source_avatar = dict["source_avatar"] as? String
        label = dict["label"] as? String
        
        //小叉号的内容数组
        if let filters = dict["filter_words"] as? [AnyObject] {
            for item in filters {
                let filterWords = YTFilterWords.init(dic: item as! [String:AnyObject])
                filter_words?.append(filterWords)
            }
        }
        
        //imagelist
        if let list = dict["image_list"] as? [AnyObject] {
            for item in list {
                let itemImage = YTImageList.init(dic: (item as! [String : AnyObject]))
                image_list.append(itemImage)
            }
        }
        
        //middle_image
        middle_image = dict["middle_image"] as? YTMiddleImageList
        
        //large_image_list
        if let largeList = dict["large_image_list"] as? [AnyObject] {
            for item in largeList {
                let large = YTLargeImageList.init(dic: item as! [String : AnyObject])
                large_image_list?.append(large)
            }
        }
        
        //video_detail_info
        if let detailVideo = dict["video_detail_info"] {
            video_detail_info = YTVideoDetailInfo.init(dic: (detailVideo as! [String : AnyObject]))
        }
        
        //media_info
        if let mediaInfo = dict["media_info"] {
            media_info = YTMediaInfo.init(dic: mediaInfo as! [String : AnyObject])
        }
        
    }
    
    
}




class YTMediaInfo : NSObject {
    var user_id : Int?
    var verified_content : String?
    var avatar_url : String?
    var media_id : Int?
    var name : String?
    var recommend_type : Int?
    var follow : Bool?
    var recommend_reason : String?
    var is_star_user : Bool?
    var user_verified : Bool?
    
    init(dic : [String : AnyObject]) {
        super.init()
        user_id = dic["user_id"] as? Int
        verified_content = dic["verified_content"] as? String
        avatar_url = dic["avatar_url"] as? String
        media_id = dic["media_id"] as? Int
        name = dic["name"] as? String
        recommend_type = dic["recommend_type"] as? Int
        follow = dic["follow"] as? Bool
        recommend_reason = dic["recommend_reason"] as? String
        is_star_user = dic["is_star_user"] as? Bool
        user_verified = dic["user_verified"] as? Bool
    }
}


class YTFilterWords : NSObject {
    var id : Int?
    var name : String?
    var is_selected : Bool?
    init(dic : [String : AnyObject]) {
        super.init()
        id = dic["id"] as? Int
        name = dic["name"] as? String
        is_selected = dic["is_selected"] as? Bool
    }
}


//MARK:----- 图片类信息
class YTImageList : NSObject {
    var url : String?
    var width : Int?
    var height : Int?
    var uri : String?
    var url_list : [[String : AnyObject]]?
    init(dic : [String : AnyObject]) {
        super.init()
        url = dic["url"] as? String
        width = dic["width"] as? Int
        height = dic["height"] as? Int
        uri = dic["uri"] as? String
        url_list = dic["url_list"] as? [[String : AnyObject]]
    }
}


class YTMiddleImageList : YTImageList {
    
}

class YTLargeImageList: YTMiddleImageList {
    
}

class YTDetailVideoLargeImage : YTImageList {
    
}


//MARK:----- 用户信息类
class YTUserInfo : NSObject {
    var verified_content : String?
    var avatar_url : String?
    var user_id : Int?
    var name : String?
    var follower_count : String?
    var follow : Bool?
    var user_auth_info : String?
    var user_verified : Bool?
    var Description : String?
    init(dic : [String : AnyObject]) {
        verified_content = dic["verified_content"] as? String
        avatar_url = dic["avatar_url"] as? String
        user_id = dic["user_id"] as? Int
        name = dic["name"] as? String
        follower_count = dic["follower_count"] as? String
        follow = dic["follow"] as? Bool
        user_auth_info = dic["user_auth_info"] as? String
        Description = dic["description"] as? String
    }
}

//MARK:---------视频详情类
class YTVideoDetailInfo : NSObject {
    var group_flags : Int?
    var video_type : Int?
    var video_preloading_flag : Int?
    var video_url : [String]?
    var direct_play : Int?
    var detail_video_large_image : YTDetailVideoLargeImage?
    var show_pgc_subscribe : Int?
    var video_third_monitor_url : String?
    var video_id :  String?
    var video_watching_count : String?
    var video_watch_count :  Int?
    init(dic : [String:AnyObject]) {
        super.init()
        group_flags = dic["group_flags"] as? Int
        video_type = dic["video_type"] as? Int
        video_preloading_flag = dic["video_preloading_flag"] as? Int
        video_url = dic["video_url"] as? [String]
        direct_play = dic["direct_play"] as? Int
        show_pgc_subscribe = dic["show_pgc_subscribe"] as? Int
        video_third_monitor_url = dic["video_third_monitor_url"] as? String
        video_id = dic["video_id"] as? String
        video_watching_count = dic["video_watching_count"] as? String
        video_watch_count = dic["video_watch_count"] as? Int
        detail_video_large_image = YTDetailVideoLargeImage.init(dic: dic["detail_video_large_image"] as! [String : AnyObject])
    }
    
}















