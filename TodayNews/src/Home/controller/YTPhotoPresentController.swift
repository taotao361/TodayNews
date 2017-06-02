//
//  YTPhotoPresentController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/2.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit
import Kingfisher


class YTPhotoPresentController: YTBaseController {

    var index : Int = 0
    var photoUrls = [String]()
    var imageViews = [UIImageView]()
    var saveIndex = 0
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "图片展示"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "save", style: .plain, target: self, action: #selector(save))
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        setupUI()
        
        
        
    }


    init(index : Int,imageUrls : [String]) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        self.photoUrls = imageUrls
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    fileprivate func setupUI() {
        
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize.init(width: SCREENW*CGFloat(photoUrls.count), height: SCREENH-64)
        
        for i in 0..<photoUrls.count {
            let imageView = UIImageView.init()
            imageView.frame = CGRect.init(x: CGFloat(i)*SCREENW, y: 0, width: SCREENW, height: SCREENH-64)
            imageView.kf.setImage(with: URL.init(string: photoUrls[i]))
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        
        if index != 0 {
            scrollView.contentOffset = CGPoint.init(x: CGFloat(index)*SCREENW, y: 64)
        }
        
    }
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.frame = CGRect.init(x: 0, y: 64, width: SCREENW, height: SCREENH)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    
    //返回
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //保存
    @objc func save() {
        UIImageWriteToSavedPhotosAlbum(imageViews[saveIndex].image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc fileprivate func image(_ image : UIImage,didFinishSavingWithError error : NSError?,contextInfo : AnyObject) {
        if error != nil {
            print(error ?? "保存失败")
        } else {
            print("保存成功")
        }
    }
    

}


extension YTPhotoPresentController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/SCREENW)
        saveIndex = index
    }
    
}


