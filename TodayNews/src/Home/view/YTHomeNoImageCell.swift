//
//  YTHomeNoImageCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/31.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  没有图片的cell类型

import UIKit

class YTHomeNoImageCell: YTHomeTopicCell {

    var newsTopic : YTNewsTopic? {
        didSet {
            titleLabel.text = newsTopic?.title
            if let publishTime = newsTopic?.publish_time {
                timeLabel.text = NSString.changeDateTime(publishTime)
            }
            
            if let sourceInfo = newsTopic?.source_avatar {
                nameLabel.text = newsTopic?.source
                avatarImage.setCircleHeader(sourceInfo)
            }
            
            if let mediaInfo = newsTopic?.media_info {
                nameLabel.text = mediaInfo.name
                avatarImage.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic?.comment_count {
                commentCount > 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") :  (commentLabel.text = "\(commentCount)评论")
            }else {
                commentLabel.isHidden = true
            }
            
            filterWords = newsTopic?.filter_words
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(label, for: UIControlState.normal)
                stickLabel.isHidden = false
                closeBtn.isHidden = (label == "置顶") ? true : false
            }
            
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
    //cell高度
//    override func cellHeight() -> CGFloat {
//        avatarImage.snp.makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//        }
//        return avatarImage.y + avatarImage.height
//    }
    
    
    


}
