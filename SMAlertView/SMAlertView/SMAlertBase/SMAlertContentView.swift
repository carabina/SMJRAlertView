//
//  SMAlertContentView.swift
//  SMAlertView
//
//  Created by 王铁山 on 2017/5/21.
//  Copyright © 2017年 KING. All rights reserved.
//

import Foundation

import UIKit

/// 本视图为弹框的内容视图。主要是提供一个可滑动的底部基础视图
/// 例如：相当于系统弹框中的按钮上部的视图（title、message）总体的父视图
open class SMAlertContentView: SMComponentView {
    
    /// 弹框内容视图 例如：相当于系统弹框中的按钮上部的视图（title、message）
    /// 调整底部可滑动视图的 contentSize 会根据此时图的高度设置
    open var alertContentView: UIView!
    
    /// 底部可滑动视图
    private var scrollView: UIScrollView!
    
    open override var frame: CGRect {
        didSet {
            SMAlertCheckMainThread()
            var f = frame
            f.size.width = SMAlertViewMaxWidth
            super.frame = f
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commitInitView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commitInitView() {
        
        SMAlertCheckMainThread()
        
        // scroll view
        let _ScrollView = UIScrollView.init(frame: CGRect.zero)
        _ScrollView.layer.masksToBounds = true
        _ScrollView.bounces = true
        _ScrollView.showsVerticalScrollIndicator = false
        _ScrollView.showsHorizontalScrollIndicator = false
        self.scrollView = _ScrollView
        
        self.contentView.addSubview(scrollView)
        
        alertContentView = UIView()
        self.scrollView.addSubview(alertContentView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutScrollView()
    }
    
    private func layoutScrollView() {

        self.scrollView.frame = self.contentView.bounds
        
        self.scrollView.contentSize = CGSize.init(width: SMAlertViewMaxWidth, height: self.alertContentView.frame.height)
        
        self.scrollView.isScrollEnabled = self.alertContentView.frame.height > self.scrollView.frame.height
        
    }
}
