//
//  SMAlertBaseView.swift
//  SMAlertBaseView
//
//  Created by KING on 2017/1/2.
//  Copyright © 2017年 KING. All rights reserved.
//

import Foundation

import UIKit

/// 此类主要提供 show 和 dismiss 两个方法来提供一个 window 全屏展示一个视图
open class SMAlertBaseView: UIView {
  
    open var strTag: String?
    
    open var dismissClick: (()->Void)?
    
    open var containerView: SMAlertContainerView!
    
    fileprivate var smWindow: UIWindow?
    
    open func show() {
        self.show(self.dismissClick)
    }
    
    open func show(_ dismissClick: (()->Void)?) {
        
        self.dismissClick = dismissClick
        
        if !SMAlertViewManager.showAlertView(self) {
            return
        }
        
        DispatchQueue.main.async {
            
            let window = UIWindow.init(frame: UIScreen.main.bounds)
            
            window.windowLevel = UIWindowLevelStatusBar
            
            window.isHidden = false
            
            self.smWindow = window
            
            window.addSubview(self)
            
            self.alpha = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 1
            }) 
            
        }
    }
    
    open func dismiss() {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
                
            }, completion: { [weak self] (finst) in
                
                self?.removeFromSuperview()
                
                self?.smWindow?.isHidden = true
                
                self?.dismissClick?()
                
                self?.smWindow = nil
                
                SMAlertViewManager.dismissAlterView()
            }) 
        }
        
    }
}
