//
//  YTHomeShareView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/5.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit


class YTShare: NSObject {
    var icon : String
    var icon_night : String
    var title : String
    init(dic : [String : AnyObject]) {
        icon = dic["icon"] as! String
        icon_night = dic["icon_night"] as! String
        title = dic["title"] as! String
        super.init()
    }
}


//调整按钮内 imageView label 位置
class YTShareVerticalButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //调整图片
        imageView?.centerX = self.width*0.5
        imageView?.y = 0
        imageView?.width = 60
         imageView?.height = 60
        
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.height)! + CGFloat(7)
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (titleLabel?.y)!
    }
    
}



class YTHomeShareView: UIView {

    class func show() {
        let shareView = YTHomeShareView()
        shareView.frame = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        window?.addSubview(shareView)
        UIView.animate(withDuration: kAnimationDuration, animations: { 
            shareView.contentView.frame = CGRect.init(x: 0, y: SCREENH - 290, width: SCREENW, height: 290)
        }) { (_) in
            shareView.addButton(shareView.topScrollView)
            //延时
            let delayTime = DispatchTime.now() + Double(Int64(0.2*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: { 
                shareView.addButton(shareView.bottomScroll)
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = YMColor(0, g: 0, b: 0, a: 0.3)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        addSubview(contentView)
        contentView.addSubview(topScrollView)
        contentView.addSubview(line)
        contentView.addSubview(bottomScroll)
        contentView.addSubview(cancelBtn)
        
        
//        contentView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.snp.bottom)
//            make.left.right.equalTo(self)
//            make.size.equalTo(CGSize.init(width: SCREENW, height: 290))
//        }
        
        contentView.frame = CGRect.init(x: 0, y: SCREENH, width: SCREENW, height: 290)
        
        topScrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: SCREENW, height: 126))
        }
        line.snp.makeConstraints { (make) in
            make.top.equalTo(topScrollView.snp.bottom).offset(1)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.size.equalTo(CGSize.init(width: SCREENW-40, height: 1))
        }
        
        bottomScroll.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom)
            make.left.right.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: SCREENW, height: 126))
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bottomScroll.snp.bottom)
            make.left.right.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: SCREENW, height: 48))
        }
        
    }
    
    //
    fileprivate lazy var contentView : UIView = {
        let contentView = UIView.init()
        contentView.backgroundColor =  YMColor(240, g: 240, b: 240, a: 1.0)
        return contentView
    }()
    
    //
    fileprivate lazy var topScrollView : UIScrollView = {
       let topScroll = UIScrollView.init()
        topScroll.showsVerticalScrollIndicator = false
        topScroll.showsHorizontalScrollIndicator = false
        topScroll.isPagingEnabled = false
        return topScroll
    }()
    
    fileprivate lazy var bottomScroll : UIScrollView = {
       let bottomScroll = UIScrollView.init()
        bottomScroll.showsVerticalScrollIndicator = false
        bottomScroll.showsHorizontalScrollIndicator = false
        bottomScroll.isPagingEnabled = false
        return bottomScroll
    }()
    
    fileprivate lazy var line : UIImageView = {
        let line = UIImageView.init()
         line.backgroundColor = YMColor(220, g: 220, b: 220, a: 1.0)
        return line
    }()
    
    //取消按钮
    fileprivate lazy var cancelBtn : UIButton = {
        let cancel = UIButton.init()
        cancel.setTitle("取消", for: UIControlState.normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        cancel.backgroundColor = UIColor.red
        cancel.addTarget(self, action: #selector(cancelBtnDidClick), for: UIControlEvents.touchUpInside)
        return cancel
    }()
    

    
    fileprivate lazy var shareItems : [YTShare] = {
        //分享item数组
        var shares = [YTShare]()
        let filePath = Bundle.main.path(forResource: "YMSharePlist.plist", ofType: nil)
        let array = NSArray.init(contentsOfFile: filePath!)
        for item in array! {
            let shareItem = YTShare.init(dic: item as! [String : AnyObject])
            shares.append(shareItem)
        }
        return shares
    }()
    
    
    //MARK: ----- 按钮点击
    @objc fileprivate func cancelBtnDidClick() {
        print(#function)
        UIView.animate(withDuration: kAnimationDuration, animations: { 
            self.contentView.frame = CGRect.init(x: 0, y: SCREENH, width: SCREENW, height: 290)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: kAnimationDuration, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: SCREENH, width: SCREENW, height: 290)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    
}



extension YTHomeShareView {
    fileprivate func addButton(_ scrollView : UIScrollView) {
        for (index,item) in shareItems.enumerated() {
            let leftMargin : CGFloat = 18
            let btnW : CGFloat = 78
            let btnY  : CGFloat = 23
            let margin_btn_margin : CGFloat = 70
            let shareButton = YTShareVerticalButton()
            shareButton.width = btnW
            shareButton.height = btnW
            shareButton.y = btnY
            shareButton.x = leftMargin + margin_btn_margin * CGFloat(index)
            shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            shareButton.setImage(UIImage.init(named: item.icon), for: UIControlState.normal)
            shareButton.setTitle(item.title, for: UIControlState.normal)
            shareButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            shareButton.addTarget(self, action: #selector(shareDidClick), for: UIControlEvents.touchUpInside)
            scrollView.addSubview(shareButton)
            scrollView.contentSize = CGSize.init(width: 18+CGFloat(index+1) * margin_btn_margin, height: 126)
        }
    }
    
    @objc fileprivate  func shareDidClick() {
        print(#function)
    }
    
}
















