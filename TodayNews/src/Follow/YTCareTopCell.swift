//
//  YTCareTopCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/6.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import Kingfisher


class YTCareTopCell: UITableViewCell {

    
    var concern : YTConcernModel? {
        didSet {
            iconImage.kf.setImage(with: URL.init(string: concern!.avatar_url))
            titleLabel.text = concern?.name
        }
    }
    
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newBtn: UIButton!
    
    @IBAction func newBtnDidClick(_ sender: UIButton) {
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
