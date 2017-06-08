//
//  YTSettingTypeThreeCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/8.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTSettingTypeThreeCell: UITableViewCell {

    var model : YTMineSettingModel? {
        didSet {
            titleLabel.text = model?.title
            rightLable.text = model?.rightTitle
        }
    }

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rightLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
