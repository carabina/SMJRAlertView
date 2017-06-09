//
//  SMAlertImageTitleMessageContentView.swift
//  SMAlertView
//
//  Created by KING on 2017/1/2.
//  Copyright © 2017年 KING. All rights reserved.
//

import UIKit

open class SMAlertImageView: SMAlertView {
    
    open var image: UIImage?
    
    open override func commitInitContainerView() {
        
        if let att = self.attributeMessage {
            self.containerView = SMAlertContainerView.init(contentView: SMAlertImageTitleMessageContentView.init(frame: CGRect.zero, title: self.title, attributeMessage: att, image: self.image, delegate: self))
        }
        else {
            self.containerView = SMAlertContainerView.init(contentView: SMAlertImageTitleMessageContentView.init(frame: CGRect.zero, title: self.title, message: self.message, image: self.image, delegate: self))
        }
        
        self.addSubview(self.containerView)
    }
    
    public init(title: String?, message: String?, image: UIImage?, delegate: SMAlertViewDelegate?, cancelButtonTitle: String?, OB:[String]?) {
        self.image = image
        super.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle, destructive: nil, OB: OB, delegate: delegate)
    }
    
    public init(title: String?, attributeMessage: NSAttributedString?, image: UIImage?, cancelButtonTitle: String?, destructive: String?, OB:[String]?, delegate: SMAlertViewDelegate?) {
        self.image = image
        super.init(title: title, attributeMessage: attributeMessage, cancelButtonTitle: cancelButtonTitle, destructive: destructive, OB: OB, delegate: delegate)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SMAlertImageView {
    
    public convenience init(title: String?, attributeMessage: NSAttributedString?, image: UIImage?, delegate: SMAlertViewDelegate?, cancelButtonTitle: String?, OB:[String]?) {
        self.init(title: title, attributeMessage: attributeMessage, image: image, cancelButtonTitle: cancelButtonTitle, destructive: nil, OB: OB, delegate: delegate)
    }
    
    public convenience init(title: String?, message: String?, image: UIImage?, cancelButtonTitle: String?) {
        
        self.init(title: title, message: message, image: image, delegate: nil, cancelButtonTitle: cancelButtonTitle, OB: nil)
    }
    
    
    public convenience init(title: String?, message: String?, image: UIImage?, cancelButtonTitle: String?, OB:[String]?) {
        
        self.init(title: title, message: message, image: image, delegate: nil, cancelButtonTitle: cancelButtonTitle, OB: OB)
    }
}


open class SMAlertImageTitleMessageContentView: SMAlertTitleMessageContentView {
    
    open var imageEdgInset: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
    
    fileprivate var image: UIImage?
    
    fileprivate var imageView: UIImageView?
    
    public init(frame: CGRect, title: String?, attributeMessage: NSAttributedString?, image: UIImage?, delegate: SMAlertTitleMessageContainerViewDelegate) {
        self.image = image
        super.init(frame: frame, title: title, attributeMessage: attributeMessage, delegate: delegate)
    }

    public init(frame: CGRect, title: String?, message: String?, image: UIImage?, delegate: SMAlertTitleMessageContainerViewDelegate) {
        self.image = image
        super.init(frame: frame, title: title, message: message, delegate: delegate)
    }
    
    open override func commitInitView() {
        self.commitInitImageView()
        super.commitInitView()
    }
    
    fileprivate func commitInitImageView() {
        
        if let img = self.image {
            // 20 img_edg_top
            // 10 title_edg_img
            self.titleEdgInset.top += img.size.height + imageEdgInset.top + imageEdgInset.bottom
            
            let _imageView = UIImageView.init(image: self.image)
            var frame = _imageView.frame
            frame.size = img.size
            frame.origin.y = imageEdgInset.top
            _imageView.frame = frame
            
            self.imageView = _imageView
            
            self.alertContentView.addSubview(_imageView)
        }
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if let imgV = self.imageView {
            var center = imgV.center
            center.x = self.frame.size.width / 2.0
            imgV.center = center
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
