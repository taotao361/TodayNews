//
//  YTVideoListController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/28.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTVideoListController: UIViewController {

    var titleModel : YTVideoTopTitleModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let random = CGFloat(arc4random() % 256)
        self.view.backgroundColor = UIColor.init(white: random/255, alpha: 1.0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
