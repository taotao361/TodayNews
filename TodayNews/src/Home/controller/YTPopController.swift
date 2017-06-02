//
//  YTPopController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/2.
//  Copyright © 2017年 yangxutao. All rights reserved.
//  弹出filter

import UIKit

class YTPopController: YTBaseController {

    var filterWords = [YTFilterWords]()
//    var fff : [YTFilterWords] = []
     fileprivate lazy var popView : YTPopView = YTPopView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(popView)
        popView.filterWords = filterWords
        popView.x = 0
        popView.y = 8
        popView.width = SCREENW - 30
        switch filterWords.count {
        case 0:
            popView.height = 0
        case 1,2:
            popView.height = 93
        case 3,4:
            popView.height = 130
        case 5,6:
            popView.height = 167
        default:
            popView.height = 0
        }
    }

    
    
    
    
}
