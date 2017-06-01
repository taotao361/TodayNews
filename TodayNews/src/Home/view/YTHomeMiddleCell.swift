//
//  YTHomeMiddleCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/31.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  右边显示一张图片的cell类型

import UIKit

class YTHomeMiddleCell: YTHomeTopicCell {


    var newTopic : YTNewsTopic? {
        didSet {
            titleLabel.text = newTopic?.title
            timeLabel.text = NSString.changeDateTime((newTopic?.publish_time!)!)
            if let sourceAvatar = newTopic?.source_avatar {
                avatarImage.setCircleHeader(sourceAvatar)
                nameLabel.text = newTopic?.source
                rightImageView.kf.setImage(with: URL.init(string: sourceAvatar))
            }
            
            if let mediaInfo = newTopic?.media_info {
                nameLabel.text = mediaInfo.name
                avatarImage.setCircleHeader(mediaInfo.avatar_url!)
                rightImageView.kf.setImage(with: URL.init(string: mediaInfo.avatar_url!))
            }
            
            if let commentCount = newTopic?.comment_count {
                commentCount > 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            
            filterWords = newTopic?.filter_words
            
            let url = newTopic?.middle_image?.url
            rightImageView.kf.setImage(with: URL.init(string: url!))
            
            if let label = newTopic?.label {
                stickLabel.setTitle("\(label)", for: UIControlState.normal)
                stickLabel.isHidden = false
            }
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(rightImageView)
        addSubview(timeButton)
        
        timeButton.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.right).offset(-5)
            make.bottom.equalTo(rightImageView.snp.bottom).offset(-5)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kHomeMargin)
            make.size.equalTo(CGSize(width: 108, height: 70))
            make.right.equalTo(self).offset(-kHomeMargin)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-kHomeMargin)
            make.left.top.equalTo(self).offset(kHomeMargin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //右边图片
    fileprivate lazy var rightImageView : UIImageView = UIImageView.init()
    
    //视频右下角的视频时长
    fileprivate lazy var timeButton : UIButton = {
       let timeBtn = UIButton.init()
        timeBtn.isHidden = true
        timeBtn.isUserInteractionEnabled = false
        timeBtn.layer.cornerRadius = 8
        timeBtn.layer.masksToBounds = true
        timeBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        timeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        timeBtn.setImage(UIImage.init(named: "palyicon_video_textpage_7x10_"), for: UIControlState.normal)
        return timeBtn
    }()
    
    //举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
//    override func cellHeight() -> CGFloat {
//        if titleLabel.frame.maxY > rightImageView.frame.maxY {
//            avatarImage.snp.makeConstraints({ (make) in
//                make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            })
//        } else {
//            avatarImage.snp.makeConstraints({ (make) in
//                make.top.equalTo(rightImageView.snp.bottom).offset(10)
//            })
//        }
//        return avatarImage.y + avatarImage.height
//    }
    
    
    
    
    

}
