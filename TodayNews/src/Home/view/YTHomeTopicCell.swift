//
//  YTHomeTopicCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/31.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  首页显示新闻的四种cell的基类

import UIKit

class YTHomeTopicCell: UITableViewCell {

    //点击cell✘显示
    var filterWords : [YTFilterWords]?
    
    var closeButtonClosure:((_ filterWords : [YTFilterWords]) -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        addSubview(stickLabel)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(avatarImage)
        addSubview(commentLabel)
        addSubview(closeBtn)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(kHomeMargin)
            make.right.equalTo(self).offset(-kHomeMargin)
        }
        
        avatarImage.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(self.snp.bottom).offset(-kHomeMargin)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImage.snp.right).offset(5)
            make.centerY.equalTo(avatarImage)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.centerY.equalTo(nameLabel)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(commentLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImage)
        }
        
        stickLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(5)
            make.centerY.equalTo(avatarImage)
            make.height.equalTo(15)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(avatarImage.snp.centerY)
            make.size.equalTo(CGSize(width: 17, height: 12))
        }
    }
    
    
    
    
    
    ///置顶 热 广告 视频
    lazy var stickLabel : UIButton = {
        let btn = UIButton.init()
        btn.isHidden = true
        btn.layer.cornerRadius = 3.0
        btn.sizeToFit()
        btn.isUserInteractionEnabled = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(YMColor(241, g: 91, b: 94, a: 1.0), for: UIControlState.normal)
        btn.layer.borderColor = YMColor(241, g: 91, b: 94, a: 1.0).cgColor
        btn.layer.borderWidth = 0.5
        return btn
    }()
    
    //新闻标题
    lazy var titleLabel : UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    //用户头像
    lazy var avatarImage : UIImageView = UIImageView.init()
    
    //用户名
    lazy var nameLabel : UILabel = {
        let name = UILabel.init()
        name.textColor = UIColor.lightGray
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    //评论
    lazy var commentLabel : UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    //时间
    lazy var timeLabel : UILabel = {
       let time = UILabel.init()
        time.font = UIFont.systemFont(ofSize: 12)
        time.textColor = UIColor.lightGray
        return time
    }()
    
    //举报按钮
    lazy var closeBtn : UIButton = {
       let close = UIButton.init()
        close.setImage(UIImage.init(named: "add_textpage_17x12_"), for: UIControlState.normal)
        close.addTarget(self, action: #selector(closeBtnClick), for: UIControlEvents.touchUpInside)
        return close
    }()
    
    //举报按钮点击
    @objc  func closeBtnClick() {
        
    }
    
    func cellHeight() -> CGFloat {
        return CGFloat.init()
    }
    

}
