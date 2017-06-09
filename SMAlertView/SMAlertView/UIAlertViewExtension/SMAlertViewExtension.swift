//
//  SMAlertViewExtension.swift
//  RosettaTobMainApp
//
//  Created by 王铁山 on 2017/3/8.
//  Copyright © 2017年 SHENMA NETWORK TECHNOLOGY (SHANGHAI) Co.,Ltd. All rights reserved.
//

import Foundation

import UIKit

public extension UIAlertView {
    
    /// UIAlertView 弹框
    public class func show(withTitle title: String?, message: String, cancelButtonTitle: String?, otherButtonTitles: [String]?, tap: ((UIAlertView, Int) -> Void)?) {
                
        _ = SMPointAlertView.init(title: title, msg: message, cancel: cancelButtonTitle, buttons: otherButtonTitles) { (index, alertView) in
            tap?(alertView, index)
        }.showPoint()
    }
    
}

@discardableResult public func Alert(title: String) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: "", cancel: nil, buttons: nil, click: nil).showPoint()
}

@discardableResult public func Alert(msg: String) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: "", msg: msg, cancel: nil, buttons: nil, click: nil).showPoint()
}

@discardableResult public func Alert(title: String, click: ((UIAlertView)->Void)?) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: "", cancel: nil, buttons: nil, click: [click]).showPoint()
}

@discardableResult public func Alert(msg: String, click: ((UIAlertView)->Void)?) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: "", msg: msg, cancel: nil, buttons: nil, click: [click]).showPoint()
}

@discardableResult public func Alert(_ msg: String) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: "", msg: msg, cancel: nil, buttons: nil, click: nil).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: nil, buttons: nil, click: nil).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, cancel: String) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: cancel, buttons: nil, click: nil).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, cancel: String, buttons: [String]) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: cancel, buttons: buttons, click: nil).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, buttons: [String]) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: nil, buttons: buttons, click: nil).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, cancel: String, click: ((UIAlertView)->Void)?...) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: cancel, buttons: nil, click: click).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, cancel: String, buttons: [String], click: ((UIAlertView)->Void)?...) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: cancel, buttons: buttons, click: click).showPoint()
}

@discardableResult public func Alert(_ title: String, msg: String, buttons: [String], click: ((UIAlertView)->Void)?...) -> SMPointAlertView {
    
    return SMPointAlertView.init(title: title, msg: msg, cancel: nil, buttons: buttons, click: click).showPoint()
}

@discardableResult public func Alert(title: String?, message: String, cancelButtonTitle: String?, otherButtonTitles: [String]?, tap: ((UIAlertView, Int) -> Void)?) -> UIAlertView {
    
    return SMPointAlertView.init(title: title, msg: message, cancel: cancelButtonTitle, buttons: otherButtonTitles) { (index, alertView) in
        tap?(alertView, index)
    }
}

/// 点语法 AlertView
open class SMPointAlertView: UIAlertView, UIAlertViewDelegate {
    
    public typealias AlertViewBlock = (_ alertView: UIAlertView)->Void
    
    public typealias AlertViewCompletionBlock = (_ index: Int, _ alertView: UIAlertView)->Void
    
    fileprivate var indexSelected = [Int : AlertViewBlock?]()
    
    fileprivate var willDismiss: AlertViewCompletionBlock?
    
    fileprivate var didDismiss: AlertViewCompletionBlock?
    
    fileprivate var willPresent: AlertViewBlock?
    
    fileprivate var didPresent: AlertViewBlock?
    
    fileprivate var cancel: AlertViewBlock?
    
    fileprivate var showEnableFirstButton: ((UIAlertView)->Bool)?
    
    fileprivate var indexTapBlock: AlertViewCompletionBlock?
    
    init (title: String?, msg: String?, cancel: String?, buttons: [String]?, click: [((UIAlertView)->Void)?]?) {
        super.init(frame: CGRect.zero)
        
        self.commitInit(title, msg: msg, cancel: cancel, buttons: buttons)
        
        guard let cc = click,   !cc.isEmpty else{
            
            return
        }
        for i in 0...cc.count - 1 {
            self.indexSelected[i] = cc[i]
        }
    }
    
    init (title: String?, msg: String?, cancel: String?, buttons: [String]?, tapBlock: (AlertViewCompletionBlock)?) {
        super.init(frame: CGRect.zero)
        
        self.commitInit(title, msg: msg, cancel: cancel, buttons: buttons)
        
        guard let block = tapBlock else {
            
            return
        }
        
        self.indexTapBlock = block
        
        for i in 0...self.numberOfButtons {
            self.indexSelected[i] = { [weak self] (alertView) in
                self?.indexTapBlock?(i, alertView)
            }
        }
    }
    
    fileprivate func commitInit(_ title: String?, msg: String?, cancel: String?, buttons: [String]?) {
        
        self.title = title ?? ""
        
        self.message = msg
        
        self.delegate = self
        
        var bs = [String]()
        
        if let c = cancel {
            bs.append(c)
            self.cancelButtonIndex = 0
        }
        
        if let ebs = buttons {
            bs.append(contentsOf: ebs)
        }
        
        if bs.isEmpty {
            bs.append("取消")
            self.cancelButtonIndex = 0
        }
    
        for btnTitle in bs {
            self.addButton(withTitle: btnTitle)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult open func showPoint() -> SMPointAlertView {
        self.show()
        return self
    }
    
    @discardableResult open func setIndexClick(_ index: Int, click: @escaping AlertViewBlock) -> SMPointAlertView {

        self.indexSelected[index] = click
        
        return self
    }
    
    @discardableResult open func setWillDismiss(_ willDismiss: @escaping AlertViewCompletionBlock) -> SMPointAlertView {
        
        self.willDismiss = willDismiss
        
        return self
    }
    
    @discardableResult open func setDidDismiss(_ didMiss: @escaping AlertViewCompletionBlock) -> SMPointAlertView {
        
        self.didDismiss = didMiss
        
        return self
    }
    
    @discardableResult open func setWillPresent(_ willPresent: @escaping AlertViewBlock) -> SMPointAlertView {
        
        self.willPresent = willPresent
        
        return self
    }
    
    @discardableResult open func setDidPresent(_ didPresent: @escaping AlertViewBlock) -> SMPointAlertView {
        
        self.didPresent = didPresent
        
        return self
    }
    
    @discardableResult open func setShouldEnableFirstOtherButton(_ enable: @escaping ((UIAlertView)->Bool)) -> SMPointAlertView  {
        
        self.showEnableFirstButton = enable
        
        return self
    }
    
    @discardableResult open func setCancel(_ cancel: @escaping AlertViewBlock) -> SMPointAlertView {
     
        self.cancel = cancel
        
        return self
    }
    
    @objc public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        guard let ss = self.indexSelected[buttonIndex] else{
            return
        }
        ss?(alertView)
    }
    
    @objc public func alertViewCancel(_ alertView: UIAlertView) {
        self.cancel?(alertView)
    }
    
    @objc public func willPresent(_ alertView: UIAlertView) {
        self.willPresent?(alertView)
    }
    
    @objc public func didPresent(_ alertView: UIAlertView) {
        self.didPresent?(alertView)
    }
    
    @objc public func alertView(_ alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        self.willDismiss?(buttonIndex, alertView)
    }
    
    @objc public func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        self.didDismiss?(buttonIndex, alertView)
    }
    
    @objc public func alertViewShouldEnableFirstOtherButton(_ alertView: UIAlertView) -> Bool {
        return self.showEnableFirstButton?(alertView) ?? true
    }
    deinit {
        
    }
}





