//
//  YTCareBottomCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/6.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTCareBottomCell: UITableViewCell {

    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var careCount: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var careBtn: UIButton!
    
    @IBAction func careBtnDidClick(_ sender: UIButton) {
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
