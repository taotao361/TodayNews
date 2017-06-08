//
//  YTPopViewAnimator.swift
//  TodayNews
//
//  Created by yangxutao on 2017/6/2.
//  Copyright © 2017年 yangxutao. All rights reserved.
//

import UIKit

class YTPopViewAnimator: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    //定义弹出视图的大小及位置
    var presentViewFrame = CGRect.zero

    //记录当前是否展开视图
    var isPresent : Bool = false
    
    //MARK:-----  UIViewControllerTransitioningDelegate

    
    /// 告诉系统由哪个控制器来实现代理
    ///
    /// - Parameters:
    ///   - presented: 被展示的视图
    ///   - presenting: 将要展示的视图
    ///   - source:
    /// - Returns: iOS 8 以后推出的专门负责转场动画的控制器
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let popVC = YTPopPresentationController.init(presentedViewController: presented, presenting: presenting)
        popVC.presentFrame = presentViewFrame
        return popVC
    }
    
    
    /// 告诉系统 谁来负责 model展示动画
    ///
    /// - Parameters:
    ///   - presented: 被展示的视图
    ///   - presenting: 将要展示的视图
    ///   - source:
    /// - Returns: 又谁管理
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    /// 告诉系统谁来负责model 消失的动画
    ///
    /// - Parameter dismissed: 消失的控制器
    /// - Returns: 有谁管理
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    
    

    //MARK:-----------  UIViewControllerAnimatedTransitioning
    //只要实现了下面两个方法，那么系统默认就没有了，所有东西都需要自己实现
    //动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    //动画实现
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            
            //将视图添加到容器上
            transitionContext.containerView.addSubview(toView!)
            //锚点
            toView?.layer.anchorPoint = CGPoint.init(x: 1.0, y: 0.0)
            //scale从0开始执行动画变大
            toView?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                toView?.transform = CGAffineTransform.identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        } else {
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
                fromView?.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    
    
    
}
