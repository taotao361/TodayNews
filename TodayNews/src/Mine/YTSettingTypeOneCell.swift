//
//  YTSettingTypeOneCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/8.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTSettingTypeOneCell: UITableViewCell {

    var model : YTMineSettingModel? {
        didSet {
            titleLable.text = model?.title
        }
    }
    
    
    @IBOutlet weak var titleLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
