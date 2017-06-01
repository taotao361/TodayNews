//
//  YTHomeSmallCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/31.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  中间三个小图cell

import UIKit

class YTHomeSmallCell: YTHomeTopicCell {

    //计算属性
    var newsTopic : YTNewsTopic? {
        didSet {
            titleLabel.text = newsTopic?.title
            timeLabel.text = NSString.changeDateTime((newsTopic?.publish_time)!)
            if let sourceAvatar = newsTopic?.source_avatar {
                nameLabel.text = newsTopic?.source
                avatarImage.setCircleHeader(sourceAvatar)
            }
            
            if let mediaInfo = newsTopic?.media_info {
                nameLabel.text = mediaInfo.name
                avatarImage.setCircleHeader(mediaInfo.avatar_url!)
            }
            
            if let commentCount = newsTopic?.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            filterWords = newsTopic?.filter_words
            print("===============\(String(describing: filterWords))")
            
            if let images = newsTopic?.image_list {
                if middleView.subviews.count > 0 { return }
                for index in 0..<images.count {
                    let imageView = UIImageView.init()
                    let item = images[index]
                    let urlString = item.url!
                    if urlString.hasSuffix(".webp") {
                        let range = urlString.replacingOccurrences(of: ".webp", with: "", options: String.CompareOptions.backwards, range: nil)
                        imageView.kf.setImage(with: URL.init(string: range))
                    } else {
                        imageView.kf.setImage(with: URL.init(string: urlString))
                    }
                
                    let width : CGFloat = (SCREENW - CGFloat(42)) / 3
                    let x : CGFloat = CGFloat(CGFloat(index) * width)
                    print("--------------------\(x)")
                    let height : CGFloat = 70
                    imageView.frame = CGRect.init(x: (x+CGFloat.init(5*index)), y: 0, width: width, height: height)
                    middleView.addSubview(imageView)
                }
            }
            
            if let label = newsTopic?.label {
                stickLabel.setTitle(label, for: UIControlState.normal)
                stickLabel.isHidden = false
            }
            
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
          contentView.addSubview(middleView)
        
        middleView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(kMargin)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.size.equalTo(CGSize.init(width: SCREENW-30, height: 70))
        }
    }
    
//    override func cellHeight() -> CGFloat {
//        avatarImage.snp.makeConstraints { (make) in
//            make.top.equalTo(middleView.snp.bottom).offset(8)
//        }
//        return avatarImage.y + avatarImage.height + kMargin
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var middleView : UIView = UIView.init()
    
    
    //举报按钮点击
    override func closeBtnClick() {
        closeButtonClosure?(filterWords)
    }
    

    
    
    
}
