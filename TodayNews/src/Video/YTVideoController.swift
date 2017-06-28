//
//  YTVideoController.swift
//  TodayNews
//
//  Created by yangxutao on 2017/5/26.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTVideoController: YTBaseController {

    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let a : Int = 3
         let arr : Array = [String]()
        
        let name : Array = ["bgbgbg","Lasasas","vfvfvf","Rddd","Pskjj"]

        func findStringIndex<T : Equatable>(_ argument : T,_ argumentArray : [T]) -> Int? {
            for (index,value) in argumentArray.enumerated() {
                if value == argument {
                    return index
                }
            }
            return nil
        }
        
        let aaa = findStringIndex("Lasasas", name)
        print(aaa ?? 00)
        
        

        
        5.repetition {
            print("hello world")
        }
        
        print(438943849[20])
        
        
        
    }


//    @objc fileprivate func click() {
//        self.hidesBottomBarWhenPushed = true
//        let sb = UIStoryboard.init(name: "Storyboard", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "YTBarController")
//        navigationController?.pushViewController(vc, animated: true)
//        hidesBottomBarWhenPushed = false
////        vc.modalTransitionStyle = .flipHorizontal
////        vc.modalPresentationStyle = .fullScreen
////        present(vc, animated: true, completion: nil)
////        UINavigationController
//    }


    
    
    

    func swapTwoValues<T>(_ a : inout T,_ b : inout T) {
        let temp = a
        a = b
        b = temp
    }

    
}













//position这个点到底要显示在哪里，由锚点决定，锚点又称定位点
//        let lay1 = CALayer.init()
//        lay1.position = CGPoint.init(x: 150, y: 200)
////        lay1.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)  锚点默认为0.5
//        lay1.backgroundColor = UIColor.red.cgColor
//        lay1.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
//        view.layer.addSublayer(lay1)
//
//
//        let lay2 = CALayer.init()
//        lay2.position = CGPoint.init(x: 150, y: 200)
//        lay2.anchorPoint = CGPoint.init(x: 0, y: 0)
//        lay2.backgroundColor = UIColor.green.cgColor
//        lay2.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
//        view.layer.addSublayer(lay2)
//
////        CAAnimation





class Stack: NSObject,SomeProtocol {
    var name : String?
    var names : [String] = [String]()
    func sayHello() {
        print("\(name ?? "haha") say hello")
    }
    
    //遵循协议
    typealias ItemType = String //可有可无，swift通过上下文判断类型
    
    func append(_ item: String) {
        names.append(item)
    }
    var count: Int {
        return names.count
    }
}


protocol SomeProtocol {
    associatedtype ItemType
    func append(_ item : ItemType)
    var count : Int { get }
}


extension Int {
    func repetition(_ task : ()->Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    //定义下标
    subscript(subscribed : Int) -> Int {
        var temp = 1
        for _ in 0..<subscribed {
            temp *= 10
        }
        return (self / temp) % 10
    }
    
}



class MyView: UIView,UIViewDelegate {
    var string: String = "hh"

    required init(name: String, age: Int) {
        
        
        
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






protocol UIViewDelegate {
    init(name : String,age : Int)
    var string : String { get }
}



protocol SomeProtocol1 : class,UIViewDelegate {
    var name : String { get set }
    func getName() -> String
    init(name : String)
}









