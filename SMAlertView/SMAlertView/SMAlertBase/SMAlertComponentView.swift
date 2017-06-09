//
//  SMAlertComponentView.swift
//  SMAlertBaseView
//
//  Created by KING on 2016/12/29.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

import UIKit


/// 检查当前线程是否是主线程，如果不是则停止运行，安全性检查
func SMAlertCheckMainThread() {
    
    guard Thread.current.isMainThread else {
        
        fatalError("SMAlertView need update UI in main thread")
    }
}

/// 组件子视图。1. 提供毛玻璃效果视图 2. 提供可调整子视图边距的功能
open class SMComponentView: UIView {
    
    /// 如果需要添加子视图，contentView 添加
    open var contentView: UIView!
    
    /// 边缘的缩进量。默认是{0.5, 0.5, 0.5, 0.5}
    open var contentInset: UIEdgeInsets = UIEdgeInsets.init(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5) {
        didSet {
            SMAlertCheckMainThread()
            self.layoutSubviews()
        }
    }
    
    /// 需要缩进的边缘
    open var contentInsertEdg: UIRectEdge = UIRectEdge.init() {
        didSet {
            SMAlertCheckMainThread()
            self.layoutSubviews()
        }
    }
    
    /// 提供的毛玻璃效果视图
    private var visualEffectView: UIVisualEffectView!
    
    /// 私有属性，指定是否在本类内部执行添加 subView 的方法
    private var privateAddSubView: Bool = false
    
    public override init(frame: CGRect) {
        privateAddSubView = true
        super.init(frame: frame)
        commitInitView()
        privateAddSubView = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        privateAddSubView = true
        super.init(coder: aDecoder)
        commitInitView()
        privateAddSubView = false
    }
    
    private func commitInitView() {
        
        SMAlertCheckMainThread()
        
        setVisualEffectView(style: UIBlurEffectStyle.extraLight)
        
        privateAddSubView = true
        
        contentView = UIView.init()
        
        self.addSubview(contentView)
    }
    
    open func setVisualEffectViewLightStyle(extraLight: Bool) {
        
        setVisualEffectView(style: extraLight ? UIBlurEffectStyle.extraLight : UIBlurEffectStyle.light)
    }
    
    open func setVisualEffectView(style: UIBlurEffectStyle) {
        
        SMAlertCheckMainThread()
        
        if let v = visualEffectView {
            
            v.removeFromSuperview()
            
            visualEffectView = nil
        }
        
        visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: style))
        
        privateAddSubView = true
        
        self.insertSubview(visualEffectView, at: 0)
        
        privateAddSubView = false
    }
    
    open func disableVisualEffectView() {
        
        if let view = visualEffectView {
            view.removeFromSuperview()
        }
    }
    
    override open func layoutSubviews() {
        
        SMAlertCheckMainThread()
        
        super.layoutSubviews()
        
        let leftInset = contentInsertEdg.contains(.left) ? contentInset.left : 0
        
        let topInset = contentInsertEdg.contains(.top) ? contentInset.top : 0
        
        let rightInset = contentInsertEdg.contains(.right) ? contentInset.right : 0
        
        let bottomInset = contentInsertEdg.contains(.bottom) ? contentInset.bottom : 0
        
        let frame = CGRect.init(x: leftInset ,
                                y: topInset,
                                width: self.frame.size.width - leftInset - rightInset,
                                height: self.frame.size.height - topInset - bottomInset)
        
        self.visualEffectView.frame = frame
        
        self.contentView.frame = frame
    }
    
    override open func addSubview(_ view: UIView) {
        
        SMAlertCheckMainThread()
        
        if privateAddSubView {
            super.addSubview(view)
        } else {
            fatalError("KKComponentView can't add subView, please use contentView to add subView")
        }
    }
}

open class SMAlertButton: SMComponentView {
    
    public enum SMAlertButtonType {
        
        case `default`      // default
        case cancel         // cancel
        case destructive    // destrutive
    }
    
    open var touchUpInsideAction: ((SMAlertButton)->Void)?
    
    /// 所持有的按钮
    open var button: UIButton!
    
    open var alterType: SMAlertButton.SMAlertButtonType = .default
    
    public var s_tag = 0
    
    init(alterType: SMAlertButton.SMAlertButtonType) {
        super.init(frame: CGRect.zero)
        comminitButton()
        self.alterType = alterType
        self.setUpWithAlterType(alterType)
        setVisualEffectViewLightStyle(extraLight: true)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        comminitButton()
        
        self.setUpWithAlterType(SMAlertButton.SMAlertButtonType.default)
        
        setVisualEffectViewLightStyle(extraLight: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func comminitButton() {
        
        SMAlertCheckMainThread()
        
        guard let _ = button else {
            
            let btn = UIButton.init(type: .custom)
            
            self.contentView.addSubview(btn)
            
            button = btn
            
            btn.addTarget(self, action: #selector(touchDown), for: UIControlEvents.touchDown)
            
            btn.addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchUpInside)
            
            btn.addTarget(self, action: #selector(touchUp), for: UIControlEvents.touchUpOutside)
            
            btn.addTarget(self, action: #selector(touchUp), for: UIControlEvents.touchCancel)
            
            btn.addTarget(self, action: #selector(touchUp), for: UIControlEvents.touchDragOutside)
            
            btn.addTarget(self, action: #selector(touchDown), for: UIControlEvents.touchDragInside)
            
            return
        }
    }
    
    @objc private func touchDown() {
        setVisualEffectViewLightStyle(extraLight: false)
        self.contentView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.45)
    }
    
    @objc private func touchUp() {
        setVisualEffectViewLightStyle(extraLight: true)
        self.contentView.backgroundColor = nil
    }
    
    @objc private func touchUpInside() {
        touchUp()
        touchUpInsideAction?(self)
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        button.frame = contentView.bounds
    }
}


// MARK: - custom with alter type

extension SMAlertButton {
    
    func setUpWithAlterType(_ alterType: SMAlertButton.SMAlertButtonType) {
        
        switch alterType {
            
        case .cancel:
            self.setUpCancelAlterType()
        case .destructive:
            self.setUpDestrutiveAlterType()
        default:
            self.setUpDefaultAlterType()
        }
        
    }
    
    fileprivate func setUpCancelAlterType() {
        
        self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.button.setTitleColor(UIColor.init(red: 0, green: 0.48, blue: 1, alpha: 1), for: UIControlState())
    }
    
    fileprivate func setUpDestrutiveAlterType() {
        
        self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.button.setTitleColor(UIColor.red, for: UIControlState())
    }
    
    fileprivate func setUpDefaultAlterType() {
        
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.button.setTitleColor(UIColor.init(red: 0, green: 0.48, blue: 1, alpha: 1), for: UIControlState())
    }
    
}


// MARK: - line

extension SMAlertButton {
    
    func setLineViewTop() {
        
        if !contentInsertEdg.contains(.top) {
            contentInsertEdg.insert(.top)
            self.layoutSubviews()
        }
    }
    
    func setLineViewRight() {
        
        if !contentInsertEdg.contains(.right) {
            contentInsertEdg.insert(.right)
            self.layoutSubviews()
        }
    }
    
    func setLineViewLeft() {
        
        if !contentInsertEdg.contains(.left) {
            contentInsertEdg.insert(.left)
            self.layoutSubviews()
        }
    }
    
}

open class SMAlertTextField: SMComponentView {
    open var s_tag = "0"
}


open class SMAlertLabel: SMComponentView {
    
    public var s_tag = "0"
    
    open var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInitView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commitInitView() {
        
        SMAlertCheckMainThread()
        
        label = UILabel.init()
        
        self.contentView.addSubview(label)
        
        disableVisualEffectView()
    }
    
    open override func layoutSubviews() {
                
        guard self.label.text != nil || self.label.attributedText != nil else {
            
            var t_frame = self.frame
            
            t_frame.size.height = 0
            
            self.frame = t_frame
            
            return
        }
        
        let width = SMAlertViewMaxWidth
        
        let labelFrame = CGRect(x: contentInset.left,
                                       y: contentInset.top,
                                       width: width - contentInset.left - contentInset.right,
                                       height: 10)
        
        let t_size = self.label.sizeThatFits(CGSize(width: labelFrame.width, height: 1000))
        
        var t_frame = self.frame
        
        t_frame.size.height = t_size.height + contentInset.top + contentInset.bottom
        
        self.frame = t_frame
        
        super.layoutSubviews()
        
        self.label.frame = CGRect(x: contentInset.left,
                                  y: contentInset.top,
                                  width: width - contentInset.left - contentInset.right,
                                  height: t_size.height)
    }
}










