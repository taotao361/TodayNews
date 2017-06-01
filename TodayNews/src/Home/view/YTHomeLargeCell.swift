//
//  YTHomeLargeCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/31.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  中间一张大图

import UIKit

class YTHomeLargeCell: YTHomeTopicCell {

    var newTopic : YTNewsTopic? {
        didSet { //观察器
            titleLabel.text = newTopic?.title
            timeLabel.text = NSString.changeDateTime((newTopic?.publish_time!)!)
            if let sourceAvatar = newTopic?.source_avatar {
                avatarImage.setCircleHeader(sourceAvatar)
                nameLabel.text = newTopic?.source
            }
            
            if let mediaInfo = newTopic?.media_info {
                nameLabel.text = mediaInfo.name
                avatarImage.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newTopic?.comment_count {
                commentCount > 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            
            filterWords = newTopic?.filter_words
            
            var urlString = String.init()
            if let videoInfo = newTopic?.video_detail_info {//视频
                urlString = videoInfo.detail_video_large_image!.url!
                //格式化时间
                let minute = Int(newTopic!.video_duration!/60)
                let second = newTopic!.video_duration! % 60
                rightBottomLabel.text = String.init(format: "%02d:%02d", minute,second)
            } else {//大图
                playBtn.isHidden = true
                urlString = (newTopic?.large_image_list?.first?.url)!
                rightBottomLabel.text = String.init(format: "%d图", newTopic!.gallary_image_count!)
            }
            
            largeImageView.kf.setImage(with: URL.init(string: urlString))
            if let label = newTopic?.label {
                if label == "" {
                    stickLabel.isHidden = true
                } else {
                    stickLabel.setTitle(label, for: UIControlState.normal)
                    stickLabel.isHidden = false
                }
            }
            
            
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(largeImageView)
        largeImageView.addSubview(rightBottomLabel)
        largeImageView.addSubview(playBtn)
        largeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kMargin)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.size.equalTo(CGSize.init(width: SCREENW-30, height: 170))
        }
        
        rightBottomLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 20))
            make.right.equalTo(largeImageView.snp.right).offset(-7)
            make.bottom.equalTo(largeImageView.snp.bottom).offset(-7)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.center.equalTo(largeImageView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //中间大图
    fileprivate lazy var largeImageView : UIImageView = {
        let largeImage = UIImageView.init()
        largeImage.backgroundColor = UIColor.lightGray
        return largeImage
    }()
    
    //视频上的播放按钮
    fileprivate lazy var playBtn : UIButton = {
        let playB = UIButton.init()
       playB.setImage(UIImage.init(named: "playicon_video_60x60_"), for: UIControlState.normal)
        playB.sizeToFit()
        playB.addTarget(self, action: #selector(playButtonClick), for: UIControlEvents.touchUpInside)
        return playB
    }()
    
    //右下角显示图片数量或视频时长
    fileprivate lazy var rightBottomLabel : UILabel = {
        let rightLable = UILabel.init()
        rightLable.textAlignment = .center
        rightLable.layer.cornerRadius = 10
        rightLable.layer.masksToBounds = true
        rightLable.font = UIFont.systemFont(ofSize: 13)
        rightLable.textColor = UIColor.white
        rightLable.backgroundColor = YMColor(0, g: 0, b: 0, a: 0.6)
        return rightLable
    }()
    
    
    //播放视频按钮点击
    func playButtonClick() {
        print("play")
    }
    
    //举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords!)
    }
    
//    override func cellHeight() -> CGFloat {
//        avatarImage.snp.makeConstraints { (make) in
//            make.top.equalTo(largeImageView.snp.bottom).offset(8)
//        }
//        return avatarImage.y + avatarImage.height
//    }
    
    
}
