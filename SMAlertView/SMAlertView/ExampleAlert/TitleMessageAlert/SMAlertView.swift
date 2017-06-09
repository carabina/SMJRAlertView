//
//  SMAlertBaseView.swift
//  SMAlertBaseView
//
//  Created by KING on 2016/12/30.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

import UIKit

/// SMAlert 的代理回掉
public protocol SMAlertViewDelegate : NSObjectProtocol {
    
    func alterViewClickButton(_ alterView: SMAlertView, buttonIndex: Int)
    
    func alterViewConfig(_ alterView: SMAlertView, titleLabel: SMAlertLabel)
    
    func alterViewConfig(_ alterView: SMAlertView, messageLabel: SMAlertLabel)
    
    func alterViewConfig(_ alterView: SMAlertView, button: SMAlertButton, index: Int)
    
}

/// SMAlert 的代理回掉默认实现
extension SMAlertViewDelegate {
    
    public func alterViewClickButton(_ alterView: SMAlertView, buttonIndex: Int) { }
    
    public func alterViewConfig(_ alterView: SMAlertView, titleLabel: SMAlertLabel) { }
    
    public func alterViewConfig(_ alterView: SMAlertView, messageLabel: SMAlertLabel) { }
    
    public func alterViewConfig(_ alterView: SMAlertView, button: SMAlertButton, index: Int) { }
    
}

open class SMAlertView: SMAlertBaseView {
    
    open weak var delegate: SMAlertViewDelegate?
    
    open var title: String?
    
    open var message: String?
    
    open var attributeMessage: NSAttributedString?
    
    open var buttonTitles: [String]?
    
    open var cancelButtonTitle: String?
    
    open var destructive: String?
    
    public init(title: String?, attributeMessage: NSAttributedString?, cancelButtonTitle: String?, destructive: String?, OB:[String]?, delegate: SMAlertViewDelegate?) {
        SMAlertCheckMainThread()
        self.title = title
        self.attributeMessage = attributeMessage
        self.delegate = delegate
        self.cancelButtonTitle = cancelButtonTitle
        self.buttonTitles = OB
        self.destructive = destructive
        super.init(frame: UIScreen.main.bounds)
        
        if self.message == nil && self.title == nil {
            fatalError("SMAlertView error: title and message both are nil")
        }
        
        self._commitInitView()
    }
    
    public init(title: String?, message: String?, cancelButtonTitle: String?, destructive: String?, OB:[String]?, delegate: SMAlertViewDelegate?) {
        SMAlertCheckMainThread()
        self.title = title
        self.message = message
        self.delegate = delegate
        self.cancelButtonTitle = cancelButtonTitle
        self.buttonTitles = OB
        self.destructive = destructive
        super.init(frame: UIScreen.main.bounds)
        
        if self.message == nil && self.title == nil {
            fatalError("SMAlertView error: title and message both are nil")
        }
        
        self._commitInitView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func commitInitContainerView() {
        
        if let att = self.attributeMessage {
            self.containerView = SMAlertContainerView.init(contentView: SMAlertTitleMessageContentView.init(frame: CGRect.zero, title: self.title, attributeMessage: att, delegate: self))
        }
        else {
            self.containerView = SMAlertContainerView.init(contentView: SMAlertTitleMessageContentView.init(frame: CGRect.zero, title: self.title, message: self.message, delegate: self))
        }
        
        self.addSubview(self.containerView)
    }
    
    fileprivate func _commitInitView() {
        
        self.backgroundColor = UIColor.init(red:0, green:0, blue:0, alpha:0.43)
        
        self.commitInitContainerView()
        
        self._commitInitButtons()
    }
    
    fileprivate func _commitInitButtons() {
        
        self.containerView.buttonsView.delegate = self
        
        if let bts = self.buttonTitles{
            
            for title in bts {
                
                self.containerView.buttonsView.addButton(SMAlertButton.SMAlertButtonType.default, configue: { (buttonsView) in
                    buttonsView.button.setTitle(title, for: UIControlState())
                })
            }
        }
        
        if let cancelT = self.cancelButtonTitle {
            
            self.containerView.buttonsView.addButton(SMAlertButton.SMAlertButtonType.cancel, configue: { (buttonsView) in
                buttonsView.button.setTitle(cancelT, for: UIControlState())
            })
        }
        
        if let destructive = self.destructive {
            self.containerView.buttonsView.addButton(SMAlertButton.SMAlertButtonType.destructive, configue: { (buttonsView) in
                buttonsView.button.setTitle(destructive, for: UIControlState())
            })
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
        self.containerView.layoutSubviews()
        self.containerView.center = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
    }
    
    public final func addButton(_ alterType: SMAlertButton.SMAlertButtonType) {
        addButton(alterType, configue: nil)
        self.setNeedsLayout()
    }
    
    public final func addButton(_ alterType: SMAlertButton.SMAlertButtonType, configue: ((SMAlertButton)->Void)?) {
        self.containerView.buttonsView.addButton(alterType, configue: configue)
        self.setNeedsLayout()
    }

}

// MARK: - init method

extension SMAlertView {
    
    /// cancel
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?) {
        self.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle, destructive: nil, OB: nil, delegate: nil)
    }
    
    /// cancel and buttons
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?, OB:[String]?) {
        self.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle, destructive: nil, OB: OB, delegate: nil)
    }
    
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?, destructive: String?) {
        self.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle, destructive: destructive, OB: nil, delegate: nil)
    }
}


extension SMAlertView: SMAlertButtonsViewDelegate {

    public func alterViewClickButton(_ alterView: SMAlertButtonsView, buttonIndex: Int) {
        delegate?.alterViewClickButton(self, buttonIndex: buttonIndex)
        self.dismiss()
    }
    
    public func alterViewConfig(_ alterView: SMAlertButtonsView, button: SMAlertButton, index: Int) {
        delegate?.alterViewConfig(self, button: button, index: index)
    }
}


extension SMAlertView: SMAlertTitleMessageContainerViewDelegate {
    
    public func alterViewConfig(_ contentView: SMAlertTitleMessageContentView, titleLabel: SMAlertLabel){
        self.delegate?.alterViewConfig(self, titleLabel: titleLabel)
    }
    
    public func alterViewConfig(_ contentView: SMAlertTitleMessageContentView, messageLabel: SMAlertLabel){
        self.delegate?.alterViewConfig(self, messageLabel: messageLabel)
    }
}





////// *************  自定义containerView 实现 title message ************ //////////


public protocol SMAlertTitleMessageContainerViewDelegate : NSObjectProtocol {
    
    func alterViewConfig(_ contentView: SMAlertTitleMessageContentView, titleLabel: SMAlertLabel)
    
    func alterViewConfig(_ contentView: SMAlertTitleMessageContentView, messageLabel: SMAlertLabel)
    
}

open class SMAlertTitleMessageContentView: SMAlertContentView {
    
    open weak var delegate: SMAlertTitleMessageContainerViewDelegate?
    
    /// 标题框
    open var titleLabel: SMAlertLabel!
    
    /// 内容框
    open var messageLabel: SMAlertLabel!
    
    /// 标题
    open var title: String?
    
    /// 内容
    open var message: String?
    
    /// 属性文本
    open var attributeMessage: NSAttributedString?

    /// 标题的边缘缩进
    open var titleEdgInset: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 0, right: 14)
    
    /// message 的边缘缩进
    open var messageEdgInset: UIEdgeInsets = UIEdgeInsets.init(top: 5, left: 20, bottom: 20, right: 14)
    
    public init(frame: CGRect, title: String?, attributeMessage: NSAttributedString?, delegate: SMAlertTitleMessageContainerViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        self.title = title
        self.attributeMessage = attributeMessage
        self.commitInitView()
    }
    
    public init(frame: CGRect, title: String?, message: String?, delegate: SMAlertTitleMessageContainerViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        self.title = title
        self.message = message
        self.commitInitView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func commitInitView() {
        
        if self.message == nil && self.title == nil {
            fatalError("SMAlertBaseView error: title and message both are nil")
        }
    
        let width = SMAlertViewMaxWidth
        
        let titleLabel = SMAlertLabel.init(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: width,
                                                         height: 10))
        titleLabel.label.numberOfLines = 0
        titleLabel.label.textColor = UIColor.black
        titleLabel.label.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.label.textAlignment = .center
        titleLabel.label.text = title
        titleLabel.contentInset = titleEdgInset
        self.delegate?.alterViewConfig(self, titleLabel: titleLabel)
        self.titleLabel = titleLabel
        
        // message
        let messageLabel = SMAlertLabel.init(frame: CGRect(x: 0,
                                                           y: titleLabel.frame.maxY,
                                                           width: width,
                                                           height: 10))
        messageLabel.label.numberOfLines = 0
        messageLabel.label.textAlignment = .center
        messageLabel.contentInset = messageEdgInset
        if let att = self.attributeMessage {
            messageLabel.label.attributedText = att
        } else {
            messageLabel.label.text = message
            messageLabel.label.textColor = UIColor.black
            messageLabel.label.font = UIFont.systemFont(ofSize: 13.5)
        }
        self.delegate?.alterViewConfig(self, messageLabel: messageLabel)
        self.messageLabel = messageLabel
        
        self.alertContentView.addSubview(self.titleLabel)
        self.alertContentView.addSubview(messageLabel)
        
        guard #available(iOS 8.0, *) else {
            self.backgroundColor = UIColor.init(white: 1, alpha: 1)
            return
        }
        
    }
    
    open override func layoutSubviews() {
        
        self.titleLabel.layoutSubviews()
        
        self.messageLabel.layoutSubviews()
        
        // 当 title maxY 为0时，使message上下居中，则 Y 等于 messageEdgInset.bottom - messageEdgInset.top
        self.messageLabel.frame = CGRect.init(x: 0, y: self.titleLabel.frame.maxY == 0 ? messageEdgInset.bottom - messageEdgInset.top: self.titleLabel.frame.maxY, width: self.messageLabel.frame.size.width, height: self.messageLabel.frame.size.height)
        
        let msgHeight = self.messageLabel.frame.height
        
        var maxH: CGFloat = 0
        
        // title nil, msg not nil。始终以 messageEdgInset.bottom 为距离底部的距离
        if msgHeight == 0 {
            
            maxH = self.titleLabel.frame.maxY + messageEdgInset.bottom
        } else {
            
            maxH = self.messageLabel.frame.maxY
        }
        
        self.alertContentView.frame = CGRect(x: 0, y: 0, width: self.alertContentView.frame.size.width, height: maxH)
        
        super.layoutSubviews()
    }

}


