//
//  YTSettingTypeTwoCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/8.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTSettingTypeTwoCell: UITableViewCell {

    var model : YTMineSettingModel? {
        didSet {
            titleLable.text = model?.title
            subtitleLable.text = model?.subtitle
            subtitleLable.isHidden = (model?.isHiddenSubtitle)!
        }
    }

    
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var subtitleLable: UILabel!
    
    @IBOutlet weak var switchBtn: UISwitch!
    
    @IBAction func switchDidClick(_ sender: UISwitch) {
        print(#function)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
