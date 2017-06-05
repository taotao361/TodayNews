//
//  YTHomeDetailBottomView.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/5.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTHomeDetailBottomView: UIView {


    var commentCount : Int? {
        didSet {
//            if commentCount != nil {
//                 commentCountLabel.text = String(commentCount!)
//            }
//            commentCountLabel.isHidden = (commentCount == 0) ? true : false
        }
    }
    
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentCountLabel.sizeToFit()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
    }
    
    
    @IBAction func textfieldDidClick(_ sender: UITextField) {
         print(#function)
    }
    
    
    @IBAction func commentBtnClock(_ sender: UIButton) {
        print(#function)
    }
    
    @IBAction func collectionBtnClick(_ sender: UIButton) {
        print(#function)
    }
    
    @IBAction func shareBtnClick(_ sender: UIButton) {
        print(#function)
        YTHomeShareView.show()
    }
    
    
    
    
}
