//
//  YTMineHeaderView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/7.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

enum ItemType : Int {
    case phone = 0
    case weichat
    case qq
    case sina
}


class YTMineHeaderView: UIView {

    //模拟登陆状态 默认未登录
    var isLogin : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        var header : UIView?
        if isLogin {
            header = YTLoginedHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 210))
        } else {
            header = YTNoLoginedHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 181))
        }
        addSubview(header!)
        loadBottomItems()
    }
    
    
    
    fileprivate func loadBottomItems() {
        
        let backView = UIView.init(frame: CGRect.init(x: 0, y: isLogin ? 210 : 181, width: SCREENW, height: 67))
        backView.backgroundColor = UIColor.clear
        addSubview(backView)
        
        var title = "收藏"
        var normalImgae = "favoriteicon_profile_24x24_"
        var highLightImage = "favoriteicon_profile_press_24x24_"
        for index in 0...2 {
            if index == 1 {
                title = "夜间"
                normalImgae = "nighticon_profile_24x24_"
                highLightImage = "nighticon_profile_press_24x24_"
            } else if index == 2 {
                title = "设置"
                normalImgae = "setupicon_profile_24x24_"
                highLightImage = "setupicon_profile_press_24x24_"
            }
            let btn = YTVerticalButton()
            btn.tag = index
            btn.frame = CGRect.init(x: CGFloat(index)*(SCREENW/3), y: 0, width: SCREENW/3, height: 67)
            btn.setTitle(title, for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.setImage(UIImage.init(named: normalImgae), for: UIControlState.normal)
            btn.setImage(UIImage.init(named: highLightImage), for: UIControlState.highlighted)
            btn.addTarget(self, action: #selector(bottomBtnDidClick(_:)), for: UIControlEvents.touchUpInside)
            backView.addSubview(btn)
        }
    }
    
   @objc fileprivate func bottomBtnDidClick(_ btn : UIButton) {
        print(#function)
    }
    
    

    
}


class YTVerticalButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.centerX = self.width/2
        imageView?.y = 10.0
        imageView?.width = 24
        imageView?.height = 24
        
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height + CGFloat(7)
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (titleLabel?.y)!
        
    }
}







class YTNoLoginedHeaderView: UIView {
    
    let items = [ItemType.phone:"cellphoneicon_login_profile_78x78_",ItemType.weichat:"weixinicon_login_profile_78x78_",ItemType.qq:"qqicon_login_profile_78x78_",ItemType.sina:"sinaicon_login_profile_78x78_"]
    
    
    var loginItemDidClick : ((_ itemType : ItemType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupUI() {
        let backView = UIImageView.init(frame: self.bounds)
        backView.image = UIImage.init(named: "wallpaper_profile")
        addSubview(backView)
        
        let btnW : CGFloat = 60
        let margin : CGFloat = 15
        let leftMargin : CGFloat = (SCREENW-(btnW+margin)*4)/2
        let btnY : CGFloat = (181 - 60)/2
        for (index,dic) in items.enumerated() {
            let key  = dic.key
            let value = dic.value
            let btn = createBtn(imageName: value, tag: key.rawValue)
            btn.x = leftMargin + CGFloat(index)*(btnW+margin)
            btn.y = btnY
            btn.width = btnW
            btn.height = btnW
            addSubview(btn)
        }
        
        addSubview(moreLoginButton)
        moreLoginButton.frame = CGRect.init(x: (SCREENW-150)/2, y: (181-23-10), width: 150, height: 23)
    }
    
    
    
    fileprivate func createBtn(imageName : String,tag : Int) -> UIButton {
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        btn.tag = tag
        btn.addTarget(self, action: #selector(itemDidClick(_:)), for: UIControlEvents.touchUpInside)
        return btn
    }
    
    fileprivate lazy var moreLoginButton: UIButton = {
        let moreLoginButton = UIButton()
        moreLoginButton.setTitle(" 更多登录方式 >", for: UIControlState())
        moreLoginButton.setTitleColor(UIColor.white, for: UIControlState())
        moreLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        moreLoginButton.backgroundColor = YMColor(170, g: 170, b: 170, a: 0.6)
        moreLoginButton.layer.cornerRadius = 15
        moreLoginButton.layer.masksToBounds = true
        moreLoginButton.addTarget(self, action: #selector(moreLoginButtonClick(_:)), for: .touchUpInside)
        return moreLoginButton
    }()
    
    @objc fileprivate func moreLoginButtonClick(_ btn : UIButton) {
        print(#function)
    }
    
    @objc fileprivate func itemDidClick(_ btn : UIButton) {
        loginItemDidClick?(ItemType(rawValue: btn.tag)!)
    }
    
}





class YTLoginedHeaderView: UIView {
    
    var avatarUrl : String? {
        didSet {
            avatarImageView.kf.setImage(with: URL.init(string: avatarUrl!))
        }
    }
    var name : String? {
        didSet {
            nameLabel.text = name!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func  setupUI() {
        addSubview(blurView)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        let avatarW : CGFloat = 69
        
        blurView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(62)
            make.left.equalTo(self.snp.left).offset((SCREENW-avatarW)/2)
            make.size.equalTo(CGSize.init(width: avatarW, height: avatarW))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(13)
            make.left.equalTo(self.snp.left)
            make.size.equalTo(CGSize.init(width: SCREENW, height: 20))
        }
        
    }
    
    fileprivate lazy var blurView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        return blurView
    }()
    
    
    fileprivate lazy var avatarImageView : UIImageView = {
        let avatar = UIImageView.init()
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = avatar.width/2
        return avatar
    }()
    
    fileprivate lazy var nameLabel : UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    

}










