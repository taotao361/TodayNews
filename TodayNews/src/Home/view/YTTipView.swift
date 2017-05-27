//
//  YTTipView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/27.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  每次刷新显示有多少新文章的view

import UIKit

class YTTipView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YMColor(215, g: 233, b: 246, a: 1.0)
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     lazy var tipLabel : UILabel = {
        let tipLabel = UILabel.init()
        tipLabel.textColor = YMColor(91, g: 162, b: 207, a: 0.9)
        tipLabel.textAlignment = .center
        tipLabel.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        return tipLabel
    }()
    
    
    
    
}
