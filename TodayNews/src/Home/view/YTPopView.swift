//
//  YTPopView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/2.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import SnapKit

//let popViewHeightDefault = 167
//let btnLeftMargin = 7
//let btnTopMargin = btnLeftMargin
let btnH  : CGFloat = 30
let topMargin = 13.5
let topViewW = (SCREENW - 30 - 26 - 7)
let btnW = topViewW/2


class YTPopView: UIView {

    var filterWords : [YTFilterWords]? {
        didSet {
            for index in 0..<filterWords!.count {
                let row = index / 2
                let column = index % 2
                let x = (btnW + 13) * CGFloat(column) + 13
                let y = (btnH + CGFloat(7)) * CGFloat(row) + 5
                let filer = filterWords![index]
                let btn = UIButton.init(type: UIButtonType.roundedRect)
                btn.frame = CGRect.init(x: x, y: y, width: btnW, height: btnH)
                btn.setTitle(filer.name, for: UIControlState.normal)
                btn.setTitleColor(UIColor.black, for: UIControlState.normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                btn.layer.cornerRadius = 5
                btn.layer.masksToBounds = true
                btn.layer.borderWidth = 0.5
                btn.layer.borderColor = UIColor.lightGray.cgColor
                btn.addTarget(self, action: #selector(filterBtnDidClick(_:)), for: UIControlEvents.touchUpInside)
                bottomView.addSubview(btn)
            }
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.addSubview(arrowView)
        self.addSubview(topView)
        self.addSubview(bottomView)
        
        arrowView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.top).offset(1)
            make.size.equalTo(CGSize.init(width: 36, height: 2))
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(arrowView.snp.bottom).offset(topMargin)
            make.left.equalTo(self.snp.left)
            make.size.equalTo(CGSize.init(width: topViewW, height: btnH))
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalTo(topView.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        
        
        
    }
    
    //
    
    fileprivate lazy var arrowView : UIImageView = {
        let arrow = UIImageView.init(image: UIImage.init(named: "arrow_up_popup_textpage_36x8_"))
//        arrow.frame = CGRect.init(x: 0, y: 0, width: SCREENW-30, height: 5)
        return arrow
    }()
    
    fileprivate lazy var topView : UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 150, height: 30))
        label.text = "可选理由，精准屏蔽"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        
        let hateBtn = UIButton.init(frame : CGRect.init(x: label.frame.maxX+50, y: label.y, width: 100, height: 30))
        hateBtn.setTitle("不感兴趣", for: UIControlState.normal)
        hateBtn.backgroundColor = UIColor.red
        hateBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        hateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        hateBtn.layer.cornerRadius = 15
        hateBtn.layer.masksToBounds = true
        hateBtn.addTarget(self, action: #selector(hateBtnDidClick), for: UIControlEvents.touchUpInside)
        view.addSubview(hateBtn)
        return view
    }()
    
    fileprivate lazy var bottomView : UIView = {
       let view = UIView.init()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    
    
    //MARK:---------------方法
    
    @objc fileprivate func filterBtnDidClick(_ btn : UIButton) {
        print("filter========")
    }
    
    
    @objc fileprivate func hateBtnDidClick() {
        print("不感兴趣")
    }
    
    
    
    
}
