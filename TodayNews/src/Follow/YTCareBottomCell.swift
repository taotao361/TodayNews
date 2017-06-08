//
//  YTCareBottomCell.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/6.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import Kingfisher
class YTCareBottomCell: UITableViewCell {

    var concern : YTConcernModel? {
        didSet {
            iconImage.kf.setImage(with: URL.init(string: concern!.avatar_url))
            titleLable.text = concern?.name
            careCount.text = "\(concern!.concern_count)人关心"
            commentCount.text = "\(concern!.discuss_count)条评论"
//            careCount.isHidden = (concern?.concern_count == 0) ? true :false
//            commentCount.isHidden = (concern?.discuss_count == 0) ? true : false
        }
    }
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var careCount: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var careBtn: UIButton!
    
    @IBAction func careBtnDidClick(_ sender: UIButton) {
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        careBtn.layer.masksToBounds = true
        careBtn.layer.cornerRadius = 5
        careBtn.layer.borderWidth = 0.6
        careBtn.layer.borderColor =  YMColor(91, g: 162, b: 207, a: 1.0).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
