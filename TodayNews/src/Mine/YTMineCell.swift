//
//  YTMineCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/7.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTMineCell: UITableViewCell {

    var mineModel : YTMineModel? {
        didSet {
            titleLable.text = mineModel?.title
            subtitleLabel.text = mineModel?.subtitle
            subtitleLabel.isHidden = (mineModel?.isHiddenSubtitle)!
        }
    }
    
    
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
