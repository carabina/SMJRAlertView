//
//  SMAlertViewManager.swift
//  SMAlertView
//
//  Created by KING on 2017/1/4.
//  Copyright © 2017年 KING. All rights reserved.
//

import UIKit

/// 弹框管理者
open class SMAlertViewManager: NSObject {

    open static let shareManager: SMAlertViewManager = SMAlertViewManager()
    
    fileprivate var currentAlertView: SMAlertBaseView?
    
    fileprivate var waitAlterViews: [SMAlertBaseView] = [SMAlertBaseView]()
    
    open class func showAlertView(_ alterView: SMAlertBaseView) -> Bool {
        return self.shareManager.showAlertView(alterView)
    }
    
    open class func dismissAlterView() {
        self.shareManager.dismissAlterView()
    }
    
    open func showAlertView(_ alterView: SMAlertBaseView) -> Bool {
                
        objc_sync_enter(self)
        
        guard let _ = self.currentAlertView else {
            
            self.currentAlertView = alterView
            
            objc_sync_exit(self)
            
            return true
            
        }
        
        self.waitAlterViews.append(alterView)
        
        objc_sync_exit(self)
        
        return false
        
    }
    
    open func dismissAlterView() {
        
        objc_sync_enter(self)
        
        self.currentAlertView = nil
        
        if !self.waitAlterViews.isEmpty {
            self.waitAlterViews[0].show()
            self.waitAlterViews.remove(at: 0)
        }
        
        objc_sync_exit(self)
    }
    
    
}



