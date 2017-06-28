//
//  YTVideoTitleView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/28.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import SnapKit

protocol YTVideoTitleViewDelegate {
    //点击标题 和 🔍
    func videoTitle(videoTitleView : YTVideoTitleView,didSelectedVideoTitle videoTitle : YTVideoTopTitleModel)
    func videoTitle(videoTitleView : YTVideoTitleView,didSelectedVideoSearchBtn btn : UIButton)
}



class YTVideoTitleView: UIView {

    //代理
    var delegate : YTVideoTitleViewDelegate?
    
    //顶部标题
    var titles = [YTVideoTopTitleModel]()
    //顶部label
    var labels = [YTTitleLable]()
    //存放label的宽度
    fileprivate var labelWidths = [CGFloat]()
    
    var currentIndex : Int = 0
    var oldIndex : Int = 0
    
    var allTitleModels : ((_ models : [YTVideoTopTitleModel]) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        YTNetworkService.shareNetService.loadVideoTopTitle { [weak self] (models) in
            if models.count > 0 {
                self?.titles += models
                self?.setUI()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK :------- 懒加载视图
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var searchBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "search_topic_24x24_"), for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.alpha = 0.6
        btn.addTarget(self, action: #selector(searchBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    
    fileprivate func setUI() {
        addSubview(scrollView)
        addSubview(searchBtn)
        
        scrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(searchBtn.snp.left)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.right.bottom.top.equalTo(self)
            make.width.equalTo(30)
        }
     
        addLabels()
        layoutLabels()
        
        //输出
        allTitleModels!(titles)
    }
    
    
    //MARK:----- search btn
    @objc fileprivate func searchBtnClick(btn : UIButton) {
        delegate?.videoTitle(videoTitleView: self, didSelectedVideoSearchBtn: btn)
    }
    
    //MARK:------- titleLabel 点击
    @objc fileprivate func labelDidTap(gesture: UITapGestureRecognizer) {
        //判断
        guard gesture.view is YTTitleLable else {
            return
        }
        
        //新旧赋值
        oldIndex = currentIndex
        currentIndex = gesture.view!.tag
        
        self.adjustTitleLabel(oldIndex: oldIndex, currentIndex: currentIndex)
        
        delegate?.videoTitle(videoTitleView: self, didSelectedVideoTitle: titles[currentIndex])
    }
    
    //MARK: ----添加label
    fileprivate func addLabels() {
        for (index,model) in self.titles.enumerated() {
            let label = YTTitleLable.init()
            label.text = model.name
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            label.isUserInteractionEnabled = true
            label.sizeToFit()
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelDidTap(gesture:)))
            label.addGestureRecognizer(tap)
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
        }
        let currentLabel = labels[0]
        currentLabel.textColor = YMColor(232, g: 84, b: 85, a: 1.0)
        currentLabel.currentScale = 1.1
    }
    
    //MARK:------- 设置label位置
    fileprivate func layoutLabels() {
        let labelH : CGFloat = self.height
        var labelX : CGFloat = 0.0
        let labelY : CGFloat = 0
        for (index,label) in labels.enumerated() {
            let labelW : CGFloat = labelWidths[index]
            if index != 0 {
                let lastLabel = labels[index - 1] //上一个label
                labelX = kMargin + lastLabel.frame.maxX
            }
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
        }
        if let labelLast = labels.last {
            scrollView.contentSize = CGSize.init(width:labelLast.frame.maxX , height: labelH)
        }
    }
    
    
    //MARK: ------ public 传给外部使用
//    func allTitleModels(_ closure : (_ models : [YTVideoTopTitleModel]) -> Void) {
//        closure(self.titles)
//    }

    func adjustTitleLabel(oldIndex : Int,currentIndex : Int) {
        
        guard currentIndex != oldIndex else {
            return
        }
        
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = YMColor(232, g: 84, b: 85, a: 1.0)
        currentLabel.currentScale = 1.1
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = UIColor.black
        oldLabel.currentScale = 1.0
        
        //最大偏移量
        let maxOffset = scrollView.contentSize.width - (scrollView.width - searchBtn.width)
        //当前偏移量
        var nowOffset = currentLabel.frame.maxX - scrollView.width*0.5
        if nowOffset < 0 {
            nowOffset = 0
        }
        if nowOffset > maxOffset {
            nowOffset = maxOffset
        }
        //设置scrollView的 偏移量
        scrollView.setContentOffset(CGPoint.init(x: nowOffset, y: 0), animated: true)
    }
    
    
}









