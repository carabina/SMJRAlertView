//
//  SMFullScreenImageAlertView.swift
//  SMAlertView
//
//  Created by KING on 2017/2/8.
//  Copyright © 2017年 KING. All rights reserved.
//

import UIKit

open class SMFullScreenImageAlertView: SMAlertBaseView {
    
    fileprivate var imagePath: String?
    
    fileprivate var imageView: UIImageView!
    
    public init (image: UIImage, dismissBtnFrame: CGRect) {
        super.init(frame: CGRect.zero)
        
        self.commitInitView(image, dismissBtnFrame: dismissBtnFrame)
    }
    
    public init (imagePath: String, dismissBtnFrame: CGRect) {
        super.init(frame: CGRect.zero)
        self.imagePath = imagePath
        self.commitInitView(nil, dismissBtnFrame: dismissBtnFrame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commitInitView(_ image: UIImage?, dismissBtnFrame: CGRect) {
        
        self.imageView = UIImageView.init(frame: CGRect.zero)
        self.imageView.image = image
        self.addSubview(self.imageView)
        
        let btn = UIButton.init(type: .custom)
        btn.frame = dismissBtnFrame
        btn.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    override open func show(_ dismissClick: (() -> Void)?) {
        
        guard let path = self.imagePath else{
            super.show(dismissClick)
            return
        }
        
        guard let urlPath = URL.init(string: path) else {
            return
        }
        
        super.show(dismissClick)
        
        self.isHidden = true
        
        if #available(iOS 8.0, *) {
            DispatchQueue.global().async { [weak self] in
                
                guard let wSelf = self else {
                    return
                }
                
                do {
                    
                    let data = try Data.init(contentsOf: urlPath)
                    
                    if let img = UIImage.init(data: data) {
                        
                        DispatchQueue.main.async(execute: { 
                            wSelf.isHidden = false
                            wSelf.imageView.image = img
                        })
                    }
                } catch {
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
    }
    
}
