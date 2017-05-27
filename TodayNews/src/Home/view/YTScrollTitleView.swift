//
//  YTScrollTitleView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/27.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  顶部滑动标题

import UIKit
import SnapKit
import Kingfisher

class YTScrollTitleView: UIView {

    //存放标题模型的数组
    var titlesModel = [YTHomeCategoryTitles]()
    //存放标题 label 数组
    var labels = [YTTitleLable]()
    //存放label的宽度
    var labelWidths = [CGFloat]()
    //顶部导航栏右边的加号按钮点击
    var addBtnClickClosure : (() ->Void)?
    //点击了一个label
    var didSelectTitleLabelClosure:((_ titleLabel : YTTitleLable)->Void)?
    //向外界传递 titles数组
    var transferTitlesClosure:((_ titleArray : [YTHomeCategoryTitles]) -> Void)?
    //记录当前选中的下标
    fileprivate var currentIndex = 0
    //记录上一个下标
    fileprivate var oldIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //获取顶部数据
        YTNetworkService.shareNetService.loadHomeTitleList { [weak self] (titleList) in
            //添加推荐标题
            let dic = ["category":"all","name":"推荐"]
            let recommend = YTHomeCategoryTitles.init(dic: dic as [String : AnyObject])
            self!.titlesModel.append(recommend)
            self!.titlesModel += titleList
            self!.setupUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        //添加scrollView
        self.addSubview(scrollView)
        self.addSubview(addButton)
        //
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp.left)
        }
        addButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        
        //添加label
        setUpTitleLabels()
        //设置label的位置
        setupLabelsPosition()
        //传递titles 数组 给外部
        transferTitlesClosure?(titlesModel)
    }
    
    //暴露给外部调用，点击了哪一个titleLabel
    func didSelectTitleLabelClosure(_ closure : @escaping (_ titleLabels : YTTitleLable)->Void) {
        didSelectTitleLabelClosure = closure
    }
    
    //暴露给外界，传递title数组
    func titleArrayClosure(_ closure : @escaping (_ titleList : [YTHomeCategoryTitles]) -> Void) {
        transferTitlesClosure = closure
    }
    
    
    
    
    
    
    
    //懒加载 scrollView
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    //添加右边按钮
    fileprivate lazy var addButton : UIButton = {
       let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "add_channel_titlbar_16x16_"), for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(addButtonClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    //右边按钮点击
    @objc fileprivate func addButtonClick() {
        addBtnClickClosure?()
    }
    
    //加号按钮点击
    func addButtonClickClosure(_ closure : @escaping ()->Void) {
        addBtnClickClosure = closure
    }
    
}

extension YTScrollTitleView {
    //添加label
    fileprivate func setUpTitleLabels() {
        for (index,category) in titlesModel.enumerated() {
            let label = YTTitleLable()
            label.text = category.name
            label.tag = index
            label.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelOnClick(_:)))
            label.addGestureRecognizer(tap)
            label.font = UIFont.systemFont(ofSize: 17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLable = labels[currentIndex]
        currentLable.textColor = UIColor.white
        currentLable.currentScale = 1.1 //label缩放
    }
    
    @objc fileprivate func titleLabelOnClick(_ tap : UITapGestureRecognizer) {
        guard  let currentLabel = tap.view as? YTTitleLable else {
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.white
        currentLabel.currentScale = 1.1
        //改变label的位置
        adjustTitleOffsetToCurrentIndex(currentIndex, oldIndex: oldIndex)
        //点击label 闭包传出去
        didSelectTitleLabelClosure?(currentLabel)
        
    }
    
    //点击标题的时候，判断是否需要改变label的位置
    func adjustTitleOffsetToCurrentIndex(_ currentIndex : Int,oldIndex : Int) {
        guard oldIndex != currentIndex else {
            return
        }
        //重新设置label的状态
        let oldLable = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.white
        oldLable.textColor = YMColor(235, g: 235, b: 235, a: 1.0)
        oldLable.currentScale = 1.0
        //当前偏移量
        var offsetX = currentLabel.centerX - SCREENW*0.5
        if offsetX < 0 {
            offsetX = 0
        }
        //最大偏移量
        var maxOffsetX = scrollView.contentSize.width - (SCREENW - addButton.width)
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
    
    
    //设置 label 的位置
    fileprivate func setupLabelsPosition() {
        var titleX : CGFloat = 0.0
        let titleY : CGFloat = 0.0
        var titleW : CGFloat = 0.0
        let titleH = self.height
        
        for (index,label) in labels.enumerated() {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel = labels[index - 1]
                titleX = lastLabel.frame.maxX + kMargin
            }
            label.frame = CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        //设置contensize
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSize.init(width: lastLabel.frame.maxX, height: 0)
        }
    }
    
    //重写frame
    override var frame: CGRect {
        didSet {
            let newF = CGRect.init(x: 0, y: 0, width: SCREENW, height: 44)
            super.frame = newF
        }
    }
    
    
}









class YTTitleLable : UILabel {
    //用来记录当前 label 的缩放比例
    var currentScale : CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform.init(scaleX: currentScale, y: currentScale)
        }
    }
}




