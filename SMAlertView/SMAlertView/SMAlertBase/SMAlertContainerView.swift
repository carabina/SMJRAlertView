//
//  SMAlertBaseView.swift
//  SMAlertBaseView
//
//  Created by KING on 2016/12/28.
//  Copyright © 2016年 KING. All rights reserved.
//

import UIKit


let SMAlertViewMaxWidth: CGFloat = 260

private let SMAlertViewMinEdg: CGFloat = 30

/// 此时图为容器类，一个弹框的内容部分，包括title，msg，buttons
open class SMAlertContainerView: UIView {
    
    /// 背景图层
    open var backgroundView: UIView?
    
    /// 容器
    open var contentView: SMAlertContentView!
    
    /// 按钮图层
    open var buttonsView: SMAlertButtonsView!
    
    public init() {
        
        super.init(frame: CGRect(x: 0, y: 0, width: SMAlertViewMaxWidth, height: 100))
        
        self.commitInitViews()
        
    }
    
    public init(contentView: SMAlertContentView) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: SMAlertViewMaxWidth, height: 100))
        
        self.contentView = contentView
        
        self.commitInitViews()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commitInitViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commitInitViews() {
        
        self.layer.masksToBounds = true
        
        self.layer.cornerRadius = 10
        
        self.commitInitContentView()
        
        self.commitInitButtonsView()
        
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        // 1. buttonsView height
        var buttonsHeight: CGFloat = 0
        
        if let btnView = buttonsView {
            buttonsHeight = btnView.buttonsHeight()
        }
        
        // 2. contentView layout 只是为了得到其alertContentView的真实的高度，至于 contentView 的高度，需要与允许的最大高度进行比较之后才能确定其所能拥有的高度
        contentView.layoutSubviews()
        
        let width = SMAlertViewMaxWidth
        
        let maxHeight = self.maxHeight()
        
        let exceptHeight = self.contentView.alertContentView.frame.height + buttonsHeight
        
        // 3. 得到真是需要展示的高度
        let height = min(maxHeight, exceptHeight)
        
        // 4. 更新自身
        var frame = self.bounds
        
        frame.size.width = width
        
        frame.size.height = height
        
        self.bounds = frame
        
        // 5. 计算得到 contentView 真实的高度并刷新
        let contentViewRealHeight = height - buttonsHeight
        
        contentView.frame = CGRect.init(x: 0, y: 0, width: width, height: contentViewRealHeight)
        
        contentView.layoutSubviews()
        
        // 6. 更新 buttonsView frame
        buttonsView.frame = CGRect.init(x: 0, y: contentViewRealHeight, width: width, height: buttonsHeight)
        
    }
    
    // 是否是横屏
    fileprivate func isLand() -> Bool {
        
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        
        return interfaceOrientation == .landscapeLeft || interfaceOrientation == .landscapeRight
    }
    
    deinit {
        
    }
    
    // MARK: - subClass overrid methods
    
    open func commitInitContentView() {
        // content view
        let _ContentView = SMAlertContentView.init(frame: CGRect.zero)
        self.contentView = self.contentView ?? _ContentView
        self.addSubview(self.contentView)
    }
    open func commitInitButtonsView() {
        
        buttonsView = SMAlertButtonsView()
        
        self.addSubview(buttonsView)
    }
    /// 可以展示的最大高度
    open func maxHeight() -> CGFloat {
        
        let size = UIScreen.main.bounds.size
        
        return self.isLand() ? size.height - 2 * SMAlertViewMinEdg : size.height - 2 * 15
    }
    
    
}

// MARK: - notification

extension SMAlertContainerView {
    
    fileprivate func bindNotification() {
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deviceOrientationDidChange(_ notification: Notification) {
        
    }
    
    
    func keyboardWillShow(_ notification: Notification) {
        
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        
    }
    
}


